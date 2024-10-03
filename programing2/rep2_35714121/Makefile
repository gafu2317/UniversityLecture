all:
	@for i in * ; do \
		if [ -d $$i -a -f $$i/Makefile ]; then \
			make  -C $$i; \
		fi; \
	done

test:
	@for i in * ; do \
		if [ -d $$i -a -f $$i/Makefile ]; then \
			make  -C $$i test; \
		fi; \
	done

clean:
	@for i in * ; do \
		if [ -d $$i -a -f $$i/Makefile ]; then \
			make  -C $$i clean; \
		fi; \
	done

utf8:
	for f in `find . -type f \( -name '*.txt' -or -name '*.java' -or -name '*.sh' -or -name 'Makefile' \) -print | sort`; do \
	c=`nkf --guess $$f`; \
	echo -n "$$f $$c -> "; \
	nkf -wLu --overwrite=.bak $$f; \
	c=`nkf --guess $$f`; \
	echo "$$c"; \
	done

sjis:
	for f in `find . -type f \( -name '*.txt' -or -name '*.java' -or -name '*.sh' -or -name 'Makefile' \) -print | sort`; do \
	c=`nkf --guess $$f`; \
	echo -n "$$f $$c -> "; \
	nkf -sLw --overwrite=.bak $$f; \
	c=`nkf --guess $$f`; \
	echo "$$c"; \
	done

zip:
	@read -p "Did you skip 'make test' (y/n [Enter]): " qtst; \
	if [ ! $$qtst = n ] && [ ! $$qtst = N ]; then \
		echo Do make test before submission.; \
		exit 1; \
	fi
	@if [ ! -f Report.txt -a ! -f Report.pdf ]; then \
		echo No report file: Report.txt or Report.pdf; \
		exit 1; \
	fi
	@sr=`wc -l Report.txt | sed 's/ [^ ]*$$//'`; \
	if [ -e Report.txt ] && [ $$sr -le 10 ]; then\
		echo Might be empty report file: Report.txt; \
		exit 1; \
	fi 
	@for f in \
	challenge kadai ensyu10-1 ensyu10-2 ensyu10-3 ensyu10-4 ensyu11-5 \
	; do if [ ! -e $$f ]; then \
		echo No such file or directory: $$f; \
		exit 1;\
	fi; \
	done
	@for f in `find . -type f -name '*.java' -print | sort`; do \
	dc=`dirname $$f`; \
	if [ ! $$dc = ./challenge ]; then \
	fc=$$dc/`basename $$f .java`.class; \
	if [ ! -e $$fc ]; then echo No class file: $$fc; exit 1; fi;\
	fi; \
	done
	@echo Archiving...
	@src=`pwd`; dst=$${src}_sub; mkdir -p $$dst && /bin/cp -Rp $$src/* $$dst/. && \
	echo Deleting .bak, .BAK  and .class files from archive ...; \
	find $$dst -type f \( -name '*.bak' -or  -name '*.BAK' -or -name '*.class' \) -delete; \
	bn=`basename $${dst}` && \
	cwd=`pwd` && \
	cd .. && zip -r $${bn}.zip $$bn && cd $$cwd && \
	echo Archived. Ok.

