const std = @import("std");
const File = std.fs.File;

pub fn getline(allocator: std.mem.Allocator, file: std.fs.File) ![]u8 {
    var buffer = std.ArrayList(u8).init(allocator);
    defer if (buffer.items.len == 0) buffer.deinit();
    var byte: [2]u8 = undefined;
    while (true) {
        const bytes_read = try file.read(byte[0..1]);
        if (bytes_read == 0) break;
        if (byte[0] == '\n') {
            try buffer.append(byte[0]);
            break;
        }
        try buffer.append(byte[0]);
    }
    return buffer.toOwnedSlice();
}
