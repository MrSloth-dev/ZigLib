pub fn findchar(str: []const u8, char: u8) isize {
    for (str, 0..) |c, index| {
        if (char != c) {
            continue;
        } else {
            return index;
        }
    }
    return -1;
}
