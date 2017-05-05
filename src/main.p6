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
    has $.name;
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

## Creature Class
class Creature {
    has $.name;
    has $.health;
    has $.strength;

    # Methods
    method new ($name, $health, $strength) {
        self.bless(:$name, :$health, :$strength)
    }

    method lose_health ($amount) {
        $!health = $!health - $amount
    }
    
    method attack ($creature) {
        my $amount = ($!strength / 10) * 3;
        $creature.lose_health($amount);
    }
    method getHealth {
        return $!health
    }
}

my $room = Room.new("Room2", Nil, Nil, Nil, "Room1", "This is a Room");
my $room2 = Room.new(Nil, "Room1", Nil, Nil, "Room2", "This is a second Room");

my %room-name = ("Room1" => $room, "Room2" => $room2);

## Human Sub-Class

class Human is Creature {
    
}

## Player Sub-Class

class Player is Creature {
    method getUsrCMD($rm, %rmhex) {

        my Str $cmd;            # Force $cmd to be a String
        
        my $loop = True; # Make Loop boolian to fuel the while statment

        while $loop {

            my $prompt = $rm.getName ~ "> ";
            print $prompt;
            $cmd = get;

            given $cmd {
                when "quit" | "exit" | "^D" { $loop = False };
                # when EOF  { $loop = False };

                when "look" {
                    # say $rm.getName();
                    say $rm.getDesc();
                };

                when "n" | "north" {
                    given $rm.getExit("north") {
                        when Str {
                            say colored("\nYou're now in " ~ $rm.getExit("north") ~ "\n", "bold green");
                            my $north = $rm.getExit("north");
                            Player.getUsrCMD(%rmhex{$north}, %rmhex);
                            $loop = False;
                        }
                        default {
                            say colored("\nYou cannot go this direction.\n", "bold red")
                        }
                    }
                }
                
                when "s" | "south" {
                    given $rm.getExit("south") {
                        when Str {
                            say colored("\nYou're now in " ~ $rm.getExit("south") ~ "\n", "bold green");
                            my $south = $rm.getExit("south");
                            Player.getUsrCMD(%rmhex{$south}, %rmhex);
                            $loop = False;
                        }
                        default {
                            say colored("\nYou cannot go this direction.\n", "bold red");
                        }
                    }
                }
                
                when "e" | "east" {
                    given $rm.getExit("east") { 
                        when Str {
                            say colored("\nYou're now in " ~ $rm.getExit("east") ~ "\n", "bold green");
                            my $east = $rm.getExit("east");
                            Player.getUsrCMD(%rmhex{$east}, %rmhex);
                            $loop = False;
                        }
                        default {
                            say colored("\nYou cannot go this direction.\n", "bold red")
                        }
                    }
                }
                
                when "w" | "west" {
                    given $rm.getExit("west") {
                        when Str {
                            say colored("\nYou're now in " ~ $rm.getExit("west") ~ "\n", "bold green");
                            my $west = $rm.getExit("west");
                            Player.getUsrCMD(%rmhex{$west}, %rmhex);
                            $loop = False;
                        }
                        default {
                            say colored("\nYou cannot go this direction.\n", "bold red")
                        }
                    }
                }
                when "health" {
                    say Player.getHealth;
                }

                when "damage" {
                    say Player.lose_health(3);
                }
                
                default {say "Undefined"};
            }
        }
    }
}

my $player = Player.new("Steve", 20, 20);

## User Command Loop

$player.getUsrCMD($room, %room-name)
