######################################################################
#
# Written By: Lorenzo Iannuzzi (aka lorenzoi) <lorenzoi@how2code.io>
#
######################################################################

# Extern Modules
use Terminal::ANSIColor;

# Testing
{
    
}
# Main Code

## Room Class
class Room {
    has $.name is rw;
    has $.desc;
    has $.nExit;
    has $.sExit;
    has $.eExit;
    has $.wExit;
    
    # Methods
    method new ($nExit, $sExit, $eExit, $wExit, $name, $desc) {
        self.bless(:$nExit, :$sExit, :$eExit, :$wExit, :$name, :$desc)
    }
    method getName () {
        return $!name
    }
    method getDesc () {
        return $!desc
    }
    method getExit ($direction) {
        given $direction {
            when "north" { return $!nExit };
            when "south" { return $!sExit };
            when "east"  { return $!eExit };
            when "west"  { return $!wExit};
            
            default { return "Undefined" };
        }
    }
}

my $room = Room.new("Room2", Nil, Nil, Nil, "Room1", "This is a Room");
my $room2 = Room.new(Nil, "Room1", Nil, Nil, "Room2", "This is a second Room");

my %room-name = ("Room1" => $room, "Room2" => $room2);

## User Command Loop

sub getUsrCMD($rm) {

    my Str $cmd; # Force $cmd to be a String
    
    my $loop = True; # Make Look boolian to fuel the while statment

    while $loop {

        my $prompt = $rm.getName ~ "> ";
        print $prompt;
        $cmd = get;

        given $cmd {
            when "quit" { $loop = False };

            when "exit" { $loop = False };
            # when EOF  { $loop = False };

            when "look" {
                # say $rm.getName();
                say $rm.getDesc();
            };

            when "n" {
                given $rm.getExit("north") {
                    when Str {
                        say colored("\nYou're now in " ~ $rm.getExit("north") ~ "\n", "bold green");
                        my $north = $rm.getExit("north");
                        getUsrCMD %room-name{$north};
                    }
                    default {
                        say colored("\nYou cannot go this direction.\n", "bold red")
                    }
                }
            }
            
            when "s" {
                given $rm.getExit("south") {
                    when Str {
                        say colored("\nYou're now in " ~ $rm.getExit("south") ~ "\n", "bold green");
                        my $south = $rm.getExit("south");
                        getUsrCMD %room-name{$south};
                    }
                    default {
                        say colored("\nYou cannot go this direction.\n", "bold red");
                    }
                }
            }
            
            when "e" {
                given $rm.getExit("east") { 
                    when Str {
                        say colored("\nYou're now in " ~ $rm.getExit("east") ~ "\n", "bold green");
                        my $east = $rm.getExit("east");
                        getUsrCMD %room-name{$east};
                    }
                    default {
                        say colored("\nYou cannot go this direction.\n", "bold red")
                    }
                }
            }
            
            when "w" {
                given $rm.getExit("west") {
                    when Str {
                        say colored("\nYou're now in " ~ $rm.getExit("west") ~ "\n", "bold green");
                        my $west = $rm.getExit("west");
                        getUsrCMD %room-name{$west};
                    }
                    default {
                        say colored("\nYou cannot go this direction.\n", "bold red")
                    }
                }
            }
            
            default {say "Undefined"};
        }
    }
}
getUsrCMD($room)
