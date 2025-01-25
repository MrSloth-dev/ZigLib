const num = @import("isdigit.zig").isdigit;

const Error = error{NotDigit};

pub fn atoi(str: []const u8) Error!i32 {
    var number: i32 = 0;
    var neg: i8 = 1;
    for (str, 0..) |char, index| {
        if (index == 0 and (char == '-' or char == '+')) {
            if (char == '-') {
                neg = -1;
                continue;
            }
        }
        if (num(char) == false and (char != '-' or char != '+'))
            return Error.NotDigit;
        number = number * 10 + char - '0';
    }
    return (number * neg);
}
