pub fn main(c: c_char) bool {
    if (c >= 'a' and c <= 'z' or c >= 'A' and c <= 'Z')
        return true;
    return false;
}
