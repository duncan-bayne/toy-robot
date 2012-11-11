# toy-robot
toy-robot is a simulator of a toy robot that moves on a tabletop.

## usage
toy-robot reads instructions from STDIN, executing them one at a time.  (On a Linux or OSX system, type C-d to generate an EOF character).

### valid commands

#### PLACE X,Y,FACING

Put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

#### MOVE

Moves the toy robot one unit forward in the direction it is currently facing.

#### LEFT

Rotates the robot 90 degrees to the left (i.e. counter-clockwise) without changing the position of the robot.

#### RIGHT

Rotates the robot 90 degrees to the right (i.e. clockwise) without changing the position of the robot.

#### REPORT

Announces the X,Y and F of the robot.

### examples of use
Interactively:

    $ toy_robot/toy_robot.rb 
    PLACE 1,1,SOUTH
    MOVE
    LEFT
    MOVE
    MOVE
    REPORT
    3,0,EAST

From a file `instructions.txt` containing instructions:

    $ cat instructions.txt | toy_robot/toy_robot.rb 
    0,0,NORTH

## licence
toy-robot is licensed under the GNU Lesser General Public License.

### why the LGPL?
The GPL is specifically designed to reduce the usefulness of GPL-licensed code to closed-source, proprietary software. The BSD license (and similar) don't mandate code-sharing if the BSD-licensed code is modified by licensees. The LGPL achieves the best of both worlds: an LGPL-licensed library can be incorporated within closed-source proprietary code, and yet those using an LGPL-licensed library are required to release source code to that library if they change it.
