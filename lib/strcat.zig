const std = @import("std");
const Error = error{NoString};

pub fn strcat(allocator: std.mem.Allocator, s1: []const u8, s2: []const u8) ![]const u8 {
    var cat = try allocator.alloc(u8, s1.len + s2.len);
    for (s1, 0..) |char1, index1| {
        cat[index1] = char1;
    }
    for (s2, 0..) |char2, index2| {
        cat[s1.len + index2] = char2;
    }
    return cat;
}
