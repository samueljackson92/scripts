// grid.js
// Date: 15/06/13
// Author: Samuel Jackson (samueljackson@outlook.com)
// Description: JavaScript grid object with functions for Conway's GOL.

function grid () {
	this.generations = 0;
	this.cells = [];
	this.livingCells = 0;
	this.maxLivingCells = 0;

	//get a cell value from the grid
	this.getCell = function (x,y) {
		//Correct overlap so grid is toroidal
		if(x < 0) x = GRID_SIZE-1;
		if(y < 0) y = GRID_SIZE-1;

		if(x >= GRID_SIZE) x = 0;
		if(y >= GRID_SIZE) y = 0;

		return this.cells[y*GRID_SIZE+x];
	}

	//set a particular cell in the grid
	this.setCell = function(x,y, val) {
		this.cells[y*GRID_SIZE+x] = val;
	}

	//loop through each cell in the grid and perform some action
	this.eachCell = function(func) {
		for (var i = 0; i < GRID_SIZE; i++) {
			for (var j = 0; j < GRID_SIZE; j++) {
				func(this.getCell(i,j), i, j);
			}
		}
	}

	this.eachNeighbour = function(x, y, func) {
		for(var i = -1; i < 2; i++) {
			for (var j = -1; j < 2; j++) {
				if(!(i === 0 && j === 0)) {
					var val = this.getNeighbour(x+i,y+j);
					func(val, x+i, y+j);
				}
			}
		}
	}

	this.step = function() {
		var newg = new grid();

		this.eachCell(function(val, x, y) {
			var nsum = g.getNeighbourSum(x,y);

			//if cell is alive
			if(val === 1) {
				//death by starvation
				if(nsum < 2) {
					newg.setCell(x,y, 0);
				}

				//lives to next stage
				if(nsum >= 2 && nsum <= 3) {newg.setCell(x,y,1);}

				//dies from overcrowding
				if(nsum > 3) {newg.setCell(x,y,0);}

			//else cell is dead
			} else {

				//if 3 neighbors, cell is offspring
				if(nsum === 3) {newg.setCell(x,y,1);}
			}
		});

		this.generations++;
		this.cells = newg.cells;
		this.maxLivingCells = Math.max(this.maxLivingCells, this.livingCells);
	}

	this.getNeighbourSum = function(x,y) {
		var sum = 0;

		this.eachNeighbour(x,y, function(val) {
			sum += val;
		});

		return sum;
	}

	this.getNeighbour = function(x,y) {
		var val = this.getCell(x,y);
		return (val === 1) ?  1 : 0;
	}
}