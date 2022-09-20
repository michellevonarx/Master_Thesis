

//Choose Channel used for Segmentation
Segment=2;

//Predefine the amount of Gaussian Blur
Blur=1.5;

//Predefine the sigma for the Laplace Filter (higher value for bigger structures)
Laplace=1;

//Predefine the Radius for Background subtraction
Backsubtract=20;

//Minimum and Maximum Value for output Image
min=0;
max=3;

inDir = getDirectory("Choose a Source Folder with images to process.");
outDir = getDirectory("Choose a Destination Folder.");

fileList = getFileList(inDir);
fileListOut = getFileList(outDir);

setBatchMode(false);
roiManager("Reset");

run("Close All");
for (i=0; i<fileList.length; i++) {
	showProgress(i+1, fileList.length);
	file = inDir + fileList[i];
  	inFileCut = lengthOf(file)-4; 
  	inFile=substring(file,0,inFileCut);
  	outFileTemp = outDir + fileList[i];
  	cut=lengthOf(outFileTemp)-4;
  	outFile=substring(outFileTemp,0,cut);
  	print("Outfile= "+outFile);
	run("Bio-Formats Importer", "open='" + file + "' color_mode=Default view=[Hyperstack] stack_order=XYCZT");

	TitleImage=getTitle();
	cut=lengthOf(TitleImage)-4;
	TitleImage2=substring(TitleImage,0,cut);
	run("32-bit");
	run("Gaussian Blur...", "sigma="+Blur+" stack");

//Split into single Images
	selectWindow(TitleImage);
	setSlice(1);
	run("Duplicate...", "title=Ch1");
	selectWindow(TitleImage);
	run("Next Slice [>]");
	run("Duplicate...", "title=Ch2");	
	selectWindow(TitleImage);
	run("Close");

//Filter for Segmentation
	selectWindow("Ch"+Segment);
	run("Duplicate...", " ");
	rename("Backsubtract");
	run("Subtract Background...", "rolling="+Backsubtract+"");
	run("FeatureJ Laplacian", "compute smoothing="+Laplace+"");
	setAutoThreshold("Triangle");
	waitForUser("Set manual Threshold, then click OK");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("32-bit");
	setAutoThreshold("Default dark");
	run("NaN Background");
	run("Divide...", "value=255");

//Create Ratiometric Image
	imageCalculator("Divide create 32-bit", "Ch1","Ch2");
	imageCalculator("Multiply create 32-bit", "Result of Ch1","Backsubtract Laplacian");

//Set Display and save
	run("Green Fire Blue");
	run("Select None");
	setMinAndMax(min, max);
	run("Calibration Bar...", "location=[Upper Right] fill=White label=Black number=5 decimal=3 font=12 zoom=1 overlay");
	saveAs("Tiff", outFile+"_ratio");
	setMinAndMax(min, max);
	run("Calibration Bar...", "location=[Upper Right] fill=White label=Black number=5 decimal=3 font=12 zoom=1");
	saveAs("Tiff", outFile+"_calibration");
	
	run("Close All");
}
**/

//Choose Channel used for Segmentation
Segment=2;

//Predefine the amount of Gaussian Blur
Blur=1.5;

//Predefine the sigma for the Laplace Filter (higher value for bigger structures)
Laplace=1;

//Predefine the Radius for Background subtraction
Backsubtract=20;

//Minimum and Maximum Value for output Image
min=0;
max=3;

inDir = getDirectory("Choose a Source Folder with images to process.");
outDir = getDirectory("Choose a Destination Folder.");

fileList = getFileList(inDir);
fileListOut = getFileList(outDir);

setBatchMode(false);
roiManager("Reset");

run("Close All");
for (i=0; i<fileList.length; i++) {
	showProgress(i+1, fileList.length);
	file = inDir + fileList[i];
  	inFileCut = lengthOf(file)-4; 
  	inFile=substring(file,0,inFileCut);
  	outFileTemp = outDir + fileList[i];
  	cut=lengthOf(outFileTemp)-4;
  	outFile=substring(outFileTemp,0,cut);
  	print("Outfile= "+outFile);
	run("Bio-Formats Importer", "open='" + file + "' color_mode=Default view=[Hyperstack] stack_order=XYCZT");

	TitleImage=getTitle();
	cut=lengthOf(TitleImage)-4;
	TitleImage2=substring(TitleImage,0,cut);
	run("32-bit");
	run("Gaussian Blur...", "sigma="+Blur+" stack");

//Split into single Images
	selectWindow(TitleImage);
	setSlice(1);
	run("Duplicate...", "title=Ch1");
	selectWindow(TitleImage);
	run("Next Slice [>]");
	run("Duplicate...", "title=Ch2");	
	selectWindow(TitleImage);
	run("Close");

//Filter for Segmentation
	selectWindow("Ch"+Segment);
	run("Duplicate...", " ");
	rename("Backsubtract");
	run("Subtract Background...", "rolling="+Backsubtract+"");
	run("FeatureJ Laplacian", "compute smoothing="+Laplace+"");
	setAutoThreshold("Triangle");
	waitForUser("Set manual Threshold, then click OK");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("32-bit");
	setAutoThreshold("Default dark");
	run("NaN Background");
	run("Divide...", "value=255");

//Create Ratiometric Image
	imageCalculator("Divide create 32-bit", "Ch1","Ch2");
	imageCalculator("Multiply create 32-bit", "Result of Ch1","Backsubtract Laplacian");

//Set Display and save
	run("Green Fire Blue");
	run("Select None");
	setMinAndMax(min, max);
	run("Calibration Bar...", "location=[Upper Right] fill=White label=Black number=5 decimal=3 font=12 zoom=1 overlay");
	saveAs("Tiff", outFile+"_ratio");
	setMinAndMax(min, max);
	run("Calibration Bar...", "location=[Upper Right] fill=White label=Black number=5 decimal=3 font=12 zoom=1");
	saveAs("Tiff", outFile+"_calibration");
	
	run("Close All");
}
