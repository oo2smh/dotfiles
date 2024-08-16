<!--==================-->
# SETUP
<!--==================-->
- Follow the qmk's website to get everything setup
- Use the qmk configurator to setup most of the keyboard's functionality.
- Download the json file from the qmk configurator
- Convert the JSON file to a C file
```
qmk json2c (name of json file) -o (name of output file)
```
- qmk compile
- qmk flash for both sides of the keyboard
- Hit the reset button and flash each keyboard (left & right)

<!--==================-->
# POSSIBLE IMPROVEMENTS
<!--==================-->
- tri-layer for commonly used actions (copy, paste, screenshot)
- combos for modifier usage (not using home row mods because it feels janky)
- Possibly get a spare keyboard in case this one breaks

<!--==================-->
# PRINCIPLES
<!--==================-->
- Try to have only 1 way to do an action (Keep it simple)
- Leverage prior mental models. Keeping qwerty for example, and numpad for numbers layer

