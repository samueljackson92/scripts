// evolve.js
// Date: 16/06/13
// Author: Samuel Jackson (samueljackson@outlook.com)
// Description: Evolves start configurations of Conway's game
// of life progressively according to a given fitness function.

var POP_SIZE = 1;
var population = [];
var currentGeneration = 0;
var noParents = 2;
var maxGenerations = 1000;
var mutationChance = 0.1;

//generate a random number between min and max (inclusive)
function generateRandomInt(min, max) {
	return Math.floor(Math.random()*++max)+min;
}

//used to seed the start population with random configurations
function generateRandomGrid() {
	var newg = new grid();

	newg.eachCell(function(val, x, y) {
		var rnd = generateRandomInt(0,1);
		newg.setCell(x,y,rnd);
	});

	return newg;
}

function generatePopulation() {

	//seed the initial population
	if(currentGeneration === 0) {
		eachGrid(function(val, key) {
			population[key] = generateRandomGrid();
		});
	//progressively evolve future generations
	} else {

	}
	
	currentGeneration++;
}

function evaluateFitness(heuristicFitness) {
	eachGrid(function(grid, key) {
		var score = heuristicFitness(grid);
	});
}

function eachGrid(func) {
	for (var i = 0; i < POP_SIZE; i++) {
		func(population[i], i);
	}
}

//flip the bit of a particular function
function flip(x,y,grid) {
	var val = (grid.getCell(x,y) === 1) ? 0 : 1;
	grid.setCell(x,y,val);
}


//fitness function
//evaluates grids based on the number of living cells
function maximizeLife(grid) {
	var score = 0;
	grid.eachCell(function(val){
		if(val === 1) score++;
	});

	return score;
}

//fitness function
//calculates the number of block still life present after the desired
//number of iterations.
function countStillBlocks(grid) {
	var score = 0;
	pattern = [0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0];
	grid.eachCell(function(val, x, y) {
		var cellScore = 0;
		if(val === 1) {
			for(var i = -1; i < 2; i++) {
				for(var j = -1; j < 2; j++) {
					if(i !== 0 && j !== 0) {
						cellScore++;
					}
				}
			}
		}

		if(cellScore === 4) score++;
	});

	return score;
}