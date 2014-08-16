#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux-x86
CND_DLIB_EXT=so
CND_CONF=Release
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/_ext/1859621399/board.o \
	${OBJECTDIR}/main.o \
	${OBJECTDIR}/_ext/1859621399/piece.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=/home/samuel/SFML-2.0/lib/libsfml-audio.so /home/samuel/SFML-2.0/lib/libsfml-graphics.so /home/samuel/SFML-2.0/lib/libsfml-network.so /home/samuel/SFML-2.0/lib/libsfml-system.so /home/samuel/SFML-2.0/lib/libsfml-window.so

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: /home/samuel/SFML-2.0/lib/libsfml-audio.so

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: /home/samuel/SFML-2.0/lib/libsfml-graphics.so

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: /home/samuel/SFML-2.0/lib/libsfml-network.so

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: /home/samuel/SFML-2.0/lib/libsfml-system.so

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: /home/samuel/SFML-2.0/lib/libsfml-window.so

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project ${OBJECTFILES} ${LDLIBSOPTIONS} 

${OBJECTDIR}/_ext/1859621399/board.o: /home/samuel/Dropbox/Personal/code/C++/chess_project/board.cpp 
	${MKDIR} -p ${OBJECTDIR}/_ext/1859621399
	${RM} $@.d
	$(COMPILE.cc) -O2 -I/home/samuel/SFML-2.0/include -MMD -MP -MF $@.d -o ${OBJECTDIR}/_ext/1859621399/board.o /home/samuel/Dropbox/Personal/code/C++/chess_project/board.cpp

${OBJECTDIR}/main.o: main.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} $@.d
	$(COMPILE.cc) -O2 -I/home/samuel/SFML-2.0/include -MMD -MP -MF $@.d -o ${OBJECTDIR}/main.o main.cpp

${OBJECTDIR}/_ext/1859621399/piece.o: /home/samuel/Dropbox/Personal/code/C++/chess_project/piece.cpp 
	${MKDIR} -p ${OBJECTDIR}/_ext/1859621399
	${RM} $@.d
	$(COMPILE.cc) -O2 -I/home/samuel/SFML-2.0/include -MMD -MP -MF $@.d -o ${OBJECTDIR}/_ext/1859621399/piece.o /home/samuel/Dropbox/Personal/code/C++/chess_project/piece.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/chess_project

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
