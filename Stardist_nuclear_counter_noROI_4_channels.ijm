folder = getDirectory("Choose a Directory to PROCESS");
filenames = getFileList(folder);
savefolder = getDirectory("Choose a Directory to SAVE the processed files");
X = filenames.length
run("Set Measurements...", "area mean min integrated density area_fraction nan redirect=None decimal=3"); //Set specific measurement for this macro
k=0;
n=0;
for (j=0; j<X; j++)
	{
	file_to_open = folder+filenames[j];
	print("loop " +j +" of " + X);
	print(folder+filenames[j]);
	open(folder+filenames[j]);
	img_name=getTitle(); //stores the name of the current image
	img_name2 = replace( img_name , ".tif" , "" ); //removes .tif extension
	list = getList("image.titles");

	rename("MAX_OG");
	selectWindow("MAX_OG");
 //	run("Z Project...", "projection=[Max Intensity]");
	
	selectWindow("MAX_OG");
	run("Duplicate...", "title=DAPI duplicate channels=1");
	selectWindow("MAX_OG");
	run("Duplicate...", "title=C2 duplicate channels=2");
	selectWindow("MAX_OG");
	run("Duplicate...", "title=C3 duplicate channels=3");
	selectWindow("MAX_OG");
	run("Duplicate...", "title=C4 duplicate channels=4");

	
	
		// Measur DAPI signal
	selectWindow("DAPI");
	run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':'DAPI', 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.500000000000001', 'nmsThresh':'0.4',	 'outputType':'ROI Manager', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");

//Measure channel 2
selectWindow("C2");
setAutoThreshold("Otsu dark");
setOption("BlackBackground", true);


for (l = 0; l < roiManager("count"); l++) { 
	selectWindow("C2");
	roiManager("Select", l);
	run("Measure");
}
saveAs("Results", savefolder + img_name2 + "C2.csv");
run("Clear Results");


	//Measure channel 3
 	selectWindow("C3");
	 setAutoThreshold("Otsu dark");
	setOption("BlackBackground", true);

for (l = 0; l < roiManager("count"); l++) { 
	selectWindow("C3");
	roiManager("Select", l);
	run("Measure");
}
saveAs("Results", savefolder + img_name2 + "C3.csv");
run("Clear Results");

	//Measure channel 4
 	selectWindow("C4");
	 setAutoThreshold("Otsu dark");
	setOption("BlackBackground", true);

for (l = 0; l < roiManager("count"); l++) { 
	selectWindow("C4");
	roiManager("Select", l);
	run("Measure");
}
saveAs("Results", savefolder + img_name2 + "C4.csv");
run("Clear Results");

	run("Close");
	run("Fresh Start");
}