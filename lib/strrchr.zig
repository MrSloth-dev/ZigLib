const Error = error{NotFound};

pub fn strrchr(str: []const u8, c: u8) Error![]const u8 {
    var len: usize = str.len - 1;
    while (len > 0) : (len -= 1) {
        if (str[len] == c)
            return str[len..];
    }
    return Error.NotFound;
}
