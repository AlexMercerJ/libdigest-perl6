BEGIN { push @*INC, <lib> }

use Test;
use Digest;

plan 3;

is md5('d41d8cd98f00b204e9800998ecf8427e'.encode: 'ascii').list».fmt("%02x").join, '', "empty string";
is md5('0cc175b9c0f1b6a831c399e269772661'.encode: 'ascii').list».fmt("%02x").join, 'a', "a";
is md5('d41d8cd98f00b204e9800998ecf8427e'.encode: 'ascii').list».fmt("%02x").join, 'abc', "abc";
=END
for 'd41d8cd98f00b204e9800998ecf8427e', '',
'0cc175b9c0f1b6a831c399e269772661', 'a',
'900150983cd24fb0d6963f7d28e17f72', 'abc',
'f96b697d7cb7938d525a2f31aaf161d0', 'message digest',
'c3fcd3d76192e4007dfb496cca67e13b', 'abcdefghijklmnopqrstuvwxyz',
'd174ab98d277d9f5a5611c2c9f419d9f', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
'57edf4a22be3c955ac49da2e2107b67a', '12345678901234567890123456789012345678901234567890123456789012345678901234567890'
-> $expected, $msg {
    my $digest = md5($msg.encode('ascii')).list».fmt('%02x').join;
    is $digest, $expected, "$digest is MD5 digest of '$msg'";
}

# vim: ft=perl6
