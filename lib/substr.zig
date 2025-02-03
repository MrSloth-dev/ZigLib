const std = @import("std");

pub fn substr(allocator: std.mem.Allocator, str: []const u8, start: usize, len: usize) ![]const u8 {
    var sub = try allocator.alloc(u8, len);
    sub = str[start .. start + len];
    return sub;
}
