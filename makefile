include config.mk

allObjs = $(allSrcs:.c=.o)
allDeps = $(allSrcs:.c=.d)

$(FinalTargetName) : CFLAG = 
$(allObjs): CFLAG = -c
$(allDeps): CFLAG = -MM

$(FinalTargetName) : $(allObjs) 
	@$(CC) $(CFLAG) $^ -o $@ 
	@cmd /K "progress.bat"
	@cmd /C "progress.py 13"

$(allObjs) : %.o : %.c 
	@$(CC) $(CFLAG) $< -o $@
	@cmd /K "progress.bat"
	@cmd /C "progress.py 13"

$(allDeps) : %.d : %.c | Dependencies
	@$(CC) $(CFLAG) $< -o $@
	@cmd /K "progress.bat"
	@cmd /C "progress.py 13"
	@copy /y $@ Dependencies\  > nul 

Dependencies:
	@mkdir $@

.PHONY: clean link onlyCompile depend all

clean: 
	DEL /Q $(FinalTargetName) $(allObjs) $(allDeps) Dependencies\*
	rmdir Dependencies
	@echo 0 > Progress.txt
	
link: 
	$(CC) $(CFLAG) $(allObjs) -o $(FinalTargetName)

onlyCompile: $(allObjs)

depend: $(allDeps)

all: $(allDeps) 
	$(MAKE) $(FinalTargetName)
	@echo 0 > Progress.txt

