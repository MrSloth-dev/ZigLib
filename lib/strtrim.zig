const findchar = @import("findchar.zig").findchar;
const std = @import("std");

pub fn strtrim(str: []const u8, charset: []const u8) []const u8 {
    var start: u8 = 0;
    for (str, 0..) |char, index| {
        if (findchar(charset, char) != -1) {
            start = @as(u8, index);
        } else {
            break;
        }
    }
    var end: u8 = str.len - 1;
    while (end >= start and (findchar(charset, str[end]) != -1)) : (end -= 1) {}
    return str[start..end];
}
