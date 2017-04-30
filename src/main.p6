######################################################################
#
# Written By: Lorenzo Iannuzzi (aka lorenzoi) <lorenzoi@how2code.io>
#
######################################################################

# Testing
{
    sub getUsrCMD() {
        my Str $cmd;
        my $loop = True;
        while $loop {
            print "> ";
            $cmd = get;
            given $cmd {
                when "quit" { $loop = False }

                default {say "Undefined"}
            }
        }
    }
    getUsrCMD
}
{
    class Room {
        has $.nExit;
        has $.sExit;
        has $.eExit;
        has $.wExit;

        # Methods
        method new ($nExit, $sExit, $eExit, $wExit) {
            self.bless(:$nExit, :$sExit, :$eExit, :$wExit)
        }
    }
    my $room = Room.new(False, False, False, False)
}

# Variables
