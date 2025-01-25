// DESCRIPTION
//        The strnstr() function locates the first occurrence of the null-terminated string little in the string big, where not more than len characters are searched.  Charac‐
//        ters  that  appear after a ‘\0’ character are not searched.  Since the strnstr() function is a FreeBSD specific API, it should only be used when portability is not a
//        concern.
// RETURN VALUES
//        If little is an empty string, big is returned; if little occurs nowhere in big, NULL is returned; otherwise a pointer to the first character of the first  occurrence
//        of little is returned.

const std = @import("std");

pub fn strnstr(little: []const u8, big: []const u8, len: usize) ![]u8 {
    for (big, 0..len) |charb, indexb| {
        if (charb == little[0]) {
            for (little, 0..) |charl, indexl| {
                if (charl != charb)
                    break;
                if (indexl == little.len)
                    return (big[indexb..]);
            }
        }
    }
}
