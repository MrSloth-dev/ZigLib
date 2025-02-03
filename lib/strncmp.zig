const std = @import("std");
const print = std.debug.print;

pub fn strncmp(str1: []const u8, str2: []const u8, len: usize) i16 {
    const min: usize = @min(str1.len, str2.len, len);
    print("{}\n", .{min});
    for (0..min) |i| {
        print("{c}", .{str1[i]});
        if (str1[i] != str2[i])
            return @as(i16, str2[i]) - @as(i16, str1[i]);
    }
    return 0;
}
