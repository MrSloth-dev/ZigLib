const Error = error{NotFound};

pub fn strchr(str: []const u8, c: u8) Error![]const u8 {
    for (str, 0..) |char, index| {
        if (char == c)
            return str[index..];
    }
    return Error.NotFound;
}
