input_path= getDirectory("choose file");
fileList= getFileList(input_path); 
Foldername=File.getName(input_path)

p = split(input_path, "")

for (i =0; i<p.length;i++){
	if (p[i]=="\\"){
		p[i]="/"
	}
}

path = String.join(p)
command = "file=[" + path + "test.xlsx] file_mode=read_and_open"


run("Read and Write Excel", command);

for(f=0; f<fileList.length; f++){
	if(endsWith(fileList[f], ".tif")){
		open(fileList[f]);

		roiManager("reset");  // clean up ROI manager and below
		run("Close All");
		run("Clear Results");
		
		open(input_path +fileList[f]);

		
		run("Duplicate...", " ");
		//run("Median...", "radius=1.5");
		//run("Smooth");
		//setAutoThreshold("Default");
		//setAutoThreshold("Otsu dark");
		setOption("ScaleConversions", true);
		run("8-bit");

		setOption("BlackBackground", false);
		run("Convert to Mask");
		//run("Auto Local Threshold", "method=Niblack radius=15 parameter_1=0 parameter_2=0 white");
		//run("Analyze Particles...", "size=3.20-Infinity circularity=0.25-1.00 show=[Overlay Masks] display add");



		
		//setThreshold(220, 496);
		//waitForUser("adjust threshold slider, then hit OK");
		//run("Convert to Mask");
		
		//setOption("BlackBackground", false);
		
		//run("Convert to Mask");

		//run("Erode");
		//run("Dilate");
		
		//run("Analyze Particles...", "size=5.2-15.00 circularity=0.35-1.00 show=Outlines display add in_situ");
		run("Analyze Particles...", "  circularity=0-0.25 display summarize add");
		roiManager("Show None");
		waitForUser("Select raw image; ROI verification");

		A=roiManager("count");
		stackFluo=newArray(A);


		for (j=0;j<stackFluo.length;j++){
			stackFluo[j]=FociMeas(j);
			
		}
		
		for (j=0;j<stackFluo.length;j++){
			setResult(getTitle,j,stackFluo[j]);
			updateResults();
		}

		run("Read and Write Excel", "file_mode=queue_write");
		close();
	}
}

run("Read and Write Excel", "file_mode=write_and_close");

function FociMeas(roi){

	roiManager("Select",roi);
	List.setMeasurements;
	Fluo=List.getValue("Mean");
	return Fluo
}




