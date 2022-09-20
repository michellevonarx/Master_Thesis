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


for(f=0; f<fileList.length; f++){
	if(endsWith(fileList[f], ".tif")){
		//open(fileList[f]);
		open(input_path +fileList[f]);
		original = getImageID();
		run("Duplicate...", " ");
		copy = getImageID();
		Title=getTitle();



		
		
		run("Subtract Background...", "rolling=20 sliding");
		run("Smooth");
		
		saveAs("tiff",path+Title+"smooth");

		//List.setMeasurements;
		//Fluo=List.getValue("Mean");
		
		



		//run("Read and Write Excel", "file_mode=queue_write");
		//run("Read and Write Excel", "file_mode=queue_write");
		run("Close");
		//close();
		
	}
	run("Close All");
}

//command = "file=[" + path + "test.xlsx]"
//run("Read and Write Excel", command);





