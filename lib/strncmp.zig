const std = @import("std");
const print = std.debug.print;
pub fn strncmp(str1: []const u8, str2: []const u8) i8 {
    var i: usize = 0;
    const min: usize = @min(str1.len, str2.len);
    while (i < min) : (i += 1) {
        print("{c}", .{str1[i]});
        if (str1[i] != str2[i])
            return @intCast(str2[i] - str1[i]);
    }
    return 0;
}
