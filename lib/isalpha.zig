pub fn isalpha(c: u8) bool {
    if (c >= 'a' and c <= 'z' or c >= 'A' and c <= 'Z')
        return true;
    return false;
}
