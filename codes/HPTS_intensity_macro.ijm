//lister les .tif dans le dossir d'interêt
dir=getDirectory("Pointer un repertoire");
fileList=getFileList(dir);
Results=newArray(fileList.length);
Foldername=File.getName(dir)
Dialog.create("Are you ready Michelle?");
Dialog.show();
unit=Dialog.getString();
run("Clear Results");

for(i=0; i<fileList.length; i++){
	if(endsWith(fileList[i], ".tif")){
		open(fileList[i]);
		
roiManager("Reset");
run("Duplicate...", "duplicate");
run("Subtract Background...", "rolling=10 stack");
		run("Smooth", "stack");
		run("Smooth", "stack");
		setAutoThreshold("MaxEntropy dark");
		run("Convert to Mask", "method=IsoData background=Dark calculate black");
//run("Threshold...");


		run("Analyze Particles...", "display add in_situ stack");
		
//selectWindow();
		//run("Clear Results");
		//waitForUser("Select Raw Image");
		roiManager("Show None");
			
		waitForUser("Select raw stack; ROI verification");
		//roiManager("Show All");
		
		//roiManager("Measure");
		A=roiManager("count");
		stackFluo=newArray(A);
		
		
		
		for (j=0;j<stackFluo.length;j++){
			stackFluo[j]=FociMeas(j);
			
		}
		
		for (j=0;j<stackFluo.length;j++){
			setResult(getTitle,j,stackFluo[j]);
			updateResults();
		}
	
		close();
	}
	
}

   index = lastIndexOf(Foldername, "."); 
   if (index!=-1) Foldername = substring(Foldername, 0, index); 
   name =Foldername + ".xlsx"; 
   saveAs("Measurements", dir+name); 
   print(dir+name); 

      



function FociMeas(roi){

	roiManager("Select",roi);
	List.setMeasurements;
	Fluo=List.getValue("Mean");
	return Fluo
}

