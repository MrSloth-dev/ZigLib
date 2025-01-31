const std = @import("std");
const lib = @import("ziglib");
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit(); // Important: clean up allocator
    const str = "Hello World! World! Home";

    const cat: []const u8 = try lib.strcat(allocator, "Hello, ", "World !\n");
    defer allocator.free(cat);
    print("{s}", .{try lib.strchr(str, 'W')});
    try lib.split("                        Wello Horld!       motherfucker\n", ' ');
    print("diff is {d}", .{lib.strncmp(cat, cat)});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "strcat" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Important: clean up allocator
    const allocator = gpa.allocator();
    const cat: []const u8 = try lib.strcat(allocator, "Hello, ", "World !\n");
    print(".{}", .{cat});
    defer allocator.free(cat);
}
