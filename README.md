# newspaper_machine
It's an automatic newspaper vending machine

Design Description:
1,It is 15 pennies for each newspaper;
2,The machine only accepts coins valuing 5 pennies and 10 pennies.
3,acceptable groups: one 5 and one 10; three 5; two 10, the machine won't pay back.

Requirements for electric circle:
1, when a customer put a coin into, a two-bit signal "coin[1:0]" would be transferred to the controller and keep one clock cycle
2, when the coin is no less than 15 pennies, the output signal "newpaper" up level and keep one clock cycle, a newpaper out.
