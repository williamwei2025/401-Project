/***********************************************************************************************************************************
COPYRIGHT AND PERMISSION NOTICE
Penn Software The Penn Haptic Texture Toolkit
Copyright (C) 2013 The Trustees of the University of Pennsylvania
All rights reserved.

See copyright and permission notice at the end of this file.

Report bugs to Heather Culbertson (hculb@seas.upenn.edu, +1 215-573-6748) or Katherine J. Kuchenbecker (kuchenbe@seas.upenn.edu, +1 215-573-2786)

This code is based on the original TexturePad haptic rendering system designed by Joseph M. Romano.
************************************************************************************************************************************/


#include <math.h>
#include <tuple>
#include "FileHelper.h"

#ifndef _ACCSYNTHHASHENTRY_H_
#define _ACCSYNTHHASHENTRY_H_


class AccSynthHashEntry
{
    public:
        AccSynthHashEntry(int mysurfType, float myforce, float myspeed, float *myLSF,
			  float myVariance, int myCoeffNum, int myNumTri, int myNumMod,
			  int *myDT1, int *myDT2, int *myDT3, float myMaxSpeed,
			  float myMaxForce, float myMu);	
        AccSynthHashEntry(int mysurfType, float myforce, float myspeed);
        AccSynthHashEntry(int mysurfType, float myforce, float myspeed, float *myLSF,
			  float *myMALSF, float myVariance, float myGain, int myCoeffNum,
			  int myMACoeffNum, int myNumTri, int myNumMod, int *myDT1, int *myDT2,
			  int *myDT3, float myMaxSpeed, float myMaxForce, float myMu);
        AccSynthHashEntry();
        ~AccSynthHashEntry();

        float mu, force, speed, variance, gain;
	float maxSpeed, maxForce;
        float * filtCoeff;
	float * filtLSF;
	float * filtMALSF;
	int * DT1;
	int * DT2;
	int * DT3;
        int surfType;
	int numCoeff;
	int numMACoeff;
	int numTri;
	int numMod;
        bool dummy;
	
};



class AccSynthHashTable
{
    public:
        AccSynthHashTable();
        AccSynthHashTable(int surfNum, int numMod, float speedMod[], float forceMod[]);
        ~AccSynthHashTable();	
        void AddEntry(AccSynthHashEntry hashEntry, int numMod, float speedMod[], float forceMod[]);
        std::tuple<int,int,double,double> HashAndInterp2(double interpSpeed, double interpForce, double filtCoeff[], double filtMACoeff[]);
        int test(int count);
    

        AccSynthHashEntry *hashMap;
        int forceHashVal(AccSynthHashEntry hashEntry, int numMod, float speedMod[], float forceMod[]);        
};

class AccSynthHashMatrix
{

    public:
        AccSynthHashMatrix(int numSurfaces);
	AccSynthHashMatrix();
        ~AccSynthHashMatrix();
	void AddTable(int surfNum, int numMod, float speedMod[], float forceMod[]);
        void AddEntry(AccSynthHashEntry hashEntry, int numMod, float speedMod[], float forceMod[]);
    std::tuple<int,int,double,double> HashAndInterp2(int interpSurf, float interpSpeed, float interpForce, double filtCoeff[], double filtMACoeff[]);
    double vibrations(int coeffNum, int MAcoeffNum, double filtVariance, double filtGain, double *filtCoeff, double *filtMACoeff, std::vector <double> &outputHist,std::vector <double> &excitationHist);
    
    private:
        AccSynthHashTable *hashTable;
        int numSurf;
        
	
};

#endif

/***********************************************************************************************************************************
COPYRIGHT AND PERMISSION NOTICE
Penn Software The Penn Haptic Texture Toolkit
Copyright (C) 2013 The Trustees of the University of Pennsylvania
All rights reserved.

The Trustees of the University of Pennsylvania (“Penn”) and Heather Culbertson, Juan Jose Lopez Delgado, and Katherine J. Kuchenbecker, the developer (“Developer”) of Penn Software The Penn Haptic Texture Toolkit (“Software”) give recipient (“Recipient”) and Recipient’s Institution (“Institution”) permission to use, copy, and modify the software in source and binary forms, with or without modification for non-profit research purposes only provided that the following conditions are met:

1)	All copies of Software in binary form and/or source code, related documentation and/or other materials provided with the Software must reproduce and retain the above copyright notice, this list of conditions and the following disclaimer.

2)	Recipient shall have the right to create modifications of the Software (“Modifications”) for their internal research and academic purposes only. 

3)	All copies of Modifications in binary form and/or source code and related documentation must reproduce and retain the above copyright notice, this list of conditions and the following disclaimer.

4)	Recipient and Institution shall not distribute Software or Modifications to any third parties without the prior written approval of Penn.

5)	Recipient will provide the Developer with feedback on the use of the Software and Modifications, if any, in their research.  The Developers and Penn are permitted to use any information Recipient provides in making changes to the Software. All feedback, bug reports and technical questions shall be sent to: 

Heather Culbertson, hculb@seas.upenn.edu, +1 215-573-6748
Katherine J. Kuchenbecker, kuchenbe@seas.upenn.edu, +1 215-573-2786

6)	Recipient acknowledges that the Developers, Penn and its licensees may develop modifications to Software that may be substantially similar to Recipient’s modifications of Software, and that the Developers, Penn and its licensees shall not be constrained in any way by Recipient in Penn’s or its licensees’ use or management of such modifications. Recipient acknowledges the right of the Developers and Penn to prepare and publish modifications to Software that may be substantially similar or functionally equivalent to your modifications and improvements, and if Recipient or Institution obtains patent protection for any modification or improvement to Software, Recipient and Institution agree not to allege or enjoin infringement of their patent by the Developers, Penn or any of Penn’s licensees obtaining modifications or improvements to Software from the Penn or the Developers.

7)	Recipient and Developer will acknowledge in their respective publications the contributions made to each other’s research involving or based on the Software. The current citations for Software are:

Heather Culbertson, Juan Jose Lopez Delgado, and Katherine J. Kuchenbecker. One Hundred Data-Driven Haptic Texture Models and Open-Source Methods for Rendering on 3D Objects. In Proc. IEEE Haptics Symposium, February 2014.

8)	Any party desiring a license to use the Software and/or Modifications for commercial purposes shall contact The Center for Technology Transfer at Penn at 215-898-9591.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS, CONTRIBUTORS, AND THE TRUSTEES OF THE UNIVERSITY OF PENNSYLVANIA "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR THE TRUSTEES OF THE UNIVERSITY OF PENNSYLVANIA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

************************************************************************************************************************************/
