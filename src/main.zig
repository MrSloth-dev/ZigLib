const std = @import("std");
const lib = @import("ziglib");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Important: clean up allocator
    const allocator = gpa.allocator();

    const cat: []const u8 = try lib.strcat(allocator, "Hello, ", "World !\n");
    defer allocator.free(cat);
    std.debug.print("Hello ++ World is -> {s}", .{cat});
    std.debug.print("{s}", .{"Hello, " ++ "World!\n"});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
