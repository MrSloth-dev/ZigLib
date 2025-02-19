const std = @import("std");
const lib = @import("ziglib");
const print = std.debug.print;

const person = struct {
    name: []const u8,
    age: u8,

    pub fn greet(Self: @This()) void {
        std.debug.print("My name is {s} and I\'m {} years old!\n", .{ Self.name, Self.age });
    }
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const arenaAlloc = arena.allocator();
    const args = try std.process.argsAlloc(arenaAlloc);
    if (args.len != 2) {
        print("Must have a file path!\n", .{});
        return;
    }
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Important: clean up allocator
    const fd = (std.fs.cwd().openFile(args[1], .{ .mode = .read_only })) catch |err| {
        print("File not found!\n Error =>{s}\n", .{@errorName(err)});
        return;
    };
    var gpaAlloc = gpa.allocator();
    const line = try lib.getline(gpaAlloc, fd);
    defer gpaAlloc.free(line);
    std.debug.print("line -> {s]}", .{line});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "strcat" {
    print("{s}Strcat Test\n{s}", .{ "\x1b[32m", "\x1b[0m" });
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Important: clean up allocator
    const allocator = gpa.allocator();
    const cat: []const u8 = try lib.strcat(allocator, "Hello, ", "World !\n");
    print("{s}", .{cat});
    defer allocator.free(cat);
}

test "strncmp" {
    print("{s}Strcmp Test\n{s}", .{ "\x1b[32m", "\x1b[0m" });
    try std.testing.expect(lib.strncmp("Hello", "hello", 5) == 32);
    try std.testing.expect(lib.strncmp("HellO", "Hello", 5) == 32);
    try std.testing.expect(lib.strncmp("HellO", "Hello", 3) == 0);
}

test "strdup" {
    print("\n{s}Strdup Test\n{s]}", .{ "\x1b[32m", "\x1b[0m" });
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    const dup = try lib.strdup(allocator, "hello");
    print("duplicate ->{s}\n", .{dup});
    defer allocator.free(dup);
    try std.testing.expect((lib.strncmp(dup, "hello", 5)) == 0);
}

test "atoi" {
    print("\n{s}Atoi Test\n{s}", .{ "\x1b[32m", "\x1b[0m" });
    try std.testing.expect(try lib.atoi.atoi("0") == 0);
    try std.testing.expect(try lib.atoi.atoi("12313") == 12313);
    try std.testing.expect(try lib.atoi.atoi("-123123321") == -123123321);

    const invalid_result = lib.atoi.atoi("a") catch |err| {
        try std.testing.expect(err == lib.atoi.Error.NotDigit);
        return;
    };
    try std.testing.expect(invalid_result == 0); // This line should never be reached
}

test "gnl" {
    print("\n{s}GNL Test\n{s]}", .{ "\x1b[32m", "\x1b[0m" });
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    const fd = try std.fs.cwd().openFile("./src/main.zig", .{ .mode = .read_only });
    var line = try lib.getline(allocator, fd);
    defer allocator.free(line);
    while (line.len != 0) {
        line = try lib.getline(allocator, fd);
        print("line ->{s}", .{line});
        allocator.free(line);
    }
}

test "strtrim" {
    print("{s}Strtrim Test\n{s}", .{ "\x1b[32m", "\x1b[0m" });
    try std.testing.expect(lib.strncmp(lib.strtrim("wwwwwwwhellowwwww", "w"), "hello", 5) == 0);
    try std.testing.expect(lib.strncmp(lib.strtrim("wawwwwwwhellowwaaaawww", "wa"), "hello", 5) == 0);
}
