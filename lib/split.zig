const std = @import("std");
const lib = @import("lib");

const Error = error{Yowtf};

pub fn split(str: []const u8, c: u8) Error!void {
    const count: usize = countWords(str, c);
    std.debug.print("\nWords : {d}\n", .{count});
}

fn countWords(str: []const u8, c: u8) usize {
    var count: usize = 0;
    var in_word: bool = false;
    for (str) |char| {
        if (char == c) {
            in_word = false;
        } else if (char != c and in_word == false) {
            in_word = true;
            count += 1;
        }
    }
    return count;
}
