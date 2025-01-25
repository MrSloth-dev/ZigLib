pub fn isprint(c: u8) bool {
    if (c > 31 and c < 127)
        return true;
    return false;
}
