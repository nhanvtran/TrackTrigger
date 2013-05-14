#! /usr/bin/env python
from ROOT import *

ROOT.gROOT.ProcessLine(".L ~/tdrstyle.C")
from ROOT import setTDRStyle
ROOT.setTDRStyle()
ROOT.gStyle.SetPadTopMargin(0.09);
#ROOT.gStyle.SetPadLeftMargin(0.16);
ROOT.gStyle.SetPadRightMargin(0.16);
ROOT.gStyle.SetHistMinimumZero();

ROOT.gStyle.SetOptTitle(1);
ROOT.gStyle.SetTitleFontSize(0.05);
ROOT.gStyle.SetTitleX(0.5);
ROOT.gStyle.SetTitleAlign(23);

ROOT.gStyle.SetPalette(1);

titleList = ["miss0",
              "miss1",
              "miss2",
              "miss0 && miss1",              
              "miss1 && miss2",              
              "miss0 && miss2",              
              "miss0 && miss1 && miss2",  
              "miss1 && layerA",
              "miss2 && layerA",
              "miss0 && miss1 && layerA",              
              "miss1 && miss2 && layerA",              
              "miss0 && miss2 && layerA",              
              "miss0 && miss1 && miss2 && layerA",  
              ];
titleOn = False;

def displayOut( olist, ctr ):
    print "display!"
    
    title = "event "+str(ctr);
    if ctr < len(titleList):
        if (not titleList[ctr] == None) and titleOn: title = titleList[ctr]
    
    hist2d = TH2I("hist2d",title+";col;row",32,0,32,128,0,128);
    hist2d.GetZaxis().SetRangeUser(0,1);
    
    print "len( olist ): ",len( olist )
    
    for i in range( len( olist ) ):
        ooo = '{0:032b}'.format( int(str(olist[i]), 16) );
        if i == 0: print "i, ",i, olist[i], ", ", ooo
        blist = list( ooo );
        for j in range( len( blist )-1,-1,-1):
            #print j+1, i+1, blist[j]
            hist2d.SetBinContent( j, i+1, int(blist[j]) );

    canO = TCanvas("canO","canO",1600,1600);
    canO.SetGrid();
    hist2d.GetXaxis().SetNdivisions(32,kFALSE);
    hist2d.GetYaxis().SetNdivisions(64,kFALSE);    
    hist2d.GetXaxis().SetLabelSize(0.02);
    hist2d.GetYaxis().SetLabelSize(0.02);
    hist2d.GetZaxis().SetLabelSize(0.);
    hist2d.GetXaxis().SetTickLength(0);    
    hist2d.GetYaxis().SetTickLength(0); 

    hist2d.Draw("colz");
    canO.SaveAs("figs_testC/test_"+str(ctr)+".eps");
    canO.SaveAs("figs_testC/test_"+str(ctr)+".png");

if __name__ == '__main__':

    
    # read text file, every 128 lines, spit out an event display
#    file = open("output/outputPattern_readMode_testB.txt", 'r');
    file = open("output/outputPattern_readMode_testC.txt", 'r');
    
    displayCtr = 0;
    lineNo = 0;
    outputList = [0]*128;
    for line in file:
        lineNo += 1;
        outputList[lineNo-1] = line.strip();
        if lineNo == 128:
            displayOut( outputList, displayCtr );
            lineNo = 0;
            outputList = [0]*128;
            displayCtr += 1;








