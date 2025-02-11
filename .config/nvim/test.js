// Linting issues: Unused variable, 'console.log' (if 'no-console' is enabled)
const unusedVar = 42

// LSP Issue: Potential typo in function name (if using a spell-checking LSP plugin)
function caluclateSum(a, b) { 
 
       

}

// Formatting issues: Inconsistent spacing, missing semicolons
const message="Hello, world!"
 console.log( message )

// Linting issue: '==' instead of '===' (if 'eqeqeq' rule is enabled)
if (5 == "5") {
  console.log("This might be a problem!");
}

// Linting issue: Function declared but not used
function unusedFunction() {
  return "I am not used!";
}

// Linting issue: Arrow function without parentheses (if 'arrow-parens' rule is enforced)
const square = n => n * n


class Animal {
  constructor(name) {
    this.name = name;
  }

  speak() {
    console.log(this.name + " makes a sound");
  }
}
