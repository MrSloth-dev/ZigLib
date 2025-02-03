const std = @import("std");

pub fn strdup(allocator: std.mem.Allocator, str: []const u8) ![]const u8 {
    var dup = try allocator.alloc(u8, str.len);
    for (0..str.len) |i| {
        dup[i] = str[i];
    }
    return dup;
}
