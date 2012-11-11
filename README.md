# toy-robot
toy-robot is a simulator of a toy robot that moves on a tabletop.

## usage
toy-robot reads instructions from STDIN, executing them one at a time until EOF is reached.  (On a Linux or OSX system, type C-d to generate an EOF character).

### valid commands

#### PLACE X,Y,FACING

Put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.  If the robot is already placed, issuing another *valid* PLACE command will place the robot in the newly specified location.

#### MOVE

Moves the toy robot one unit forward in the direction it is currently facing.

#### LEFT

Rotates the robot 90 degrees to the left (i.e. counter-clockwise) without changing the position of the robot.

#### RIGHT

Rotates the robot 90 degrees to the right (i.e. clockwise) without changing the position of the robot.

#### REPORT

Announces the X,Y and F of the robot.

### installing

Ensure you have [Git](http://git-scm.com/downloads) and either [Ruby 1.9.3](http://www.ruby-lang.org/en/downloads/) or [RVM](https://rvm.io/rvm/install/) installed.  Then in a console execute:

    git clone git://github.com/duncan-bayne/toy-robot.git
    cd toy-robot
    gem install bundler
    bundle install

RVM will prompt you if you need to install the version of Ruby upon which toy-robot relies (1.9.3).

### supported operating systems

toy-robot *should* install on pretty much any recent UNIX or UNIX-like operating system, and Microsoft Windows.  I have tested it on 64-bit Linux Mint 13 (Maya) and 32-bit Windows 7.

### running

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

With invalid commands:

    $ toy_robot/toy_robot.rb 
    PLACE 0,0,WOMBLES
    Ignoring PLACE with invalid arguments.
    MOVE
    Ignoring MOVE until robot is PLACEd.
    PLACE 1,1,NORTH

## development notes

I developed toy-robot test first; you can see the [commit log](https://github.com/duncan-bayne/toy-robot/commits/master) for how I proceeded.

I made the following assumptions:

 * lines that are either empty or contain only whitespace can be completely ignored
 * multiple valid PLACE statements are valid
 * case-sensitivity was by design (e.g. `PLACE` but not `place`)
 * abbreviations are not allowed (e.g. `NORTH` but not `N`)
 * comma separators are required (e.g. `0,0,NORTH` but not `0 0 NORTH`)
 * this is a UNIX program (so it observes the [Rule of Silence](http://www.faqs.org/docs/artu/ch01s06.html) and only reports on errors or when instructed)

Depending upon the time available and the background of the intended users, some of those assumptions could easily be challenged.  E.g. Windows users are not used to case sensitivity or silent success.

Specs, documentation and quality checks are automated through rake.  E.g. to display a list of all tasks:

    $ rake -T
    rake default        # Runs all specs and quality tests, then generates documentation
    rake documentation  # Generates HTML documentation from Markdown files
    rake quality        # Check for design issues in: **/*.rb
    rake specs          # Run RSpec code examples

To run everything:

    $ rake
    /home/duncan/.rvm/rubies/ruby-1.9.3-p194/bin/ruby -S rspec spec/simulator_integration_spec.rb spec/table_
    spec.rb spec/robot_spec.rb spec/simulator_spec.rb --backtrace                                           
    ...................................................
     
    Finished in 0.01306 seconds
    51 examples, 0 failures
    markdown 1.0.0 on Ruby 1.9.3 (2012-04-20) [x86_64-linux]
    searching folder '.'...
      skipping file   'Gemfile.lock'...
      skipping file   'README.html'...
      skipping folder 'spec'...
      skipping folder 'toy_robot'...
      skipping file   '.rvmrc'...
      skipping folder 'doc'...
      skipping file   'Gemfile'...
      skipping file   'Rakefile'...
      skipping file   'COPYING'...
      skipping file   'roodi.yml'...
      skipping folder '.git'...
    *** README.md (.) => README.html (.)...
      Removing %-comments (0 lines, 0 begin/end-blocks, 0 end-blocks)...
      Converting Markdown-text (2338 bytes) to HTML using library kramdown (0.14.0)
      using options:
    {}
    Done.

If I were to add any more commands, or increase the complexity of the commands, I would consider refactoring the Simulator class to use the [Command Pattern](http://en.wikipedia.org/wiki/Command_pattern).  That would allow easy unit testing of the individual commands.

## licence
toy-robot is licensed under the GNU Lesser General Public License.

### why the LGPL?
The GPL is specifically designed to reduce the usefulness of GPL-licensed code to closed-source, proprietary software. The BSD license (and similar) do not mandate code-sharing if the BSD-licensed code is modified by licensees. The LGPL achieves the best of both worlds: an LGPL-licensed library can be incorporated within closed-source proprietary code, and yet those using an LGPL-licensed library are required to release source code to that library if they change it.
