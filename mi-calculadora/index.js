const readline = require('readline/promises');
const ADDITION = require('./operations/add.js');
const SUBSTRACTION = require('./operations/substract.js');
const MULTIPLICATION = require('./operations/multiply.js')
const DIVIDE = require('./operations/divide.js')

const rl = readline.createInterface(process.stdin, process.stdout);
async function main() {



  let operation, numbers = [];
  const operations = ["ADD", "SUB", ",MULT", "DIV"];
  let keepgoing = true;

  while (keepgoing) {

    const answer = await rl.question(`¿Wich operation do you want to do?
  1.-ADD 
  2.-SUBSTRACTION 
  3.-MULTIPLICATION 
  4.-DIVIDE
  0.-EXIT
  `);
    operation = Number(answer);

    if (answer === '0') {
      keepgoing = false;
      console.log("See you master!");
    }
    else {
      numbers[0] = Number(await rl.question(`Input a number 1 to ${operations[operation - 1]}
  `));
      numbers[1] = Number(await rl.question(`Input a number 2 to ${operations[operation - 1]}
  `));
      console.log((`The ${operations[operation - 1]} result is: `));
      switch (operation) {
        case 1:
          console.log(ADDITION.add(numbers[0], numbers[1]));
          break;
        case 2:
          console.log(SUBSTRACTION.sub(numbers[0], numbers[1]));
          break;
        case 3:
          console.log(MULTIPLICATION.mul(numbers[0], numbers[1]));
          break;
        case 4:
          console.log(DIVIDE.div(numbers[0], numbers[1]));
          break;
      }


    }
  }
  rl.close();

}


main();