const alpha = @import("isalpha.zig");
const num = @import("isdigit.zig");

pub fn isalnum(c: u8) bool {
    if (alpha.isalpha(c) and num.isdigit())
        return true;
    return false;
}
