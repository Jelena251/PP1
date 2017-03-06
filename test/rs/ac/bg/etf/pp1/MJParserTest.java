package rs.ac.bg.etf.pp1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import java_cup.runtime.Symbol;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

import rs.ac.bg.etf.pp1.util.Log4JUtils;
import rs.etf.pp1.mj.runtime.Code;
import rs.etf.pp1.symboltable.Tab;
import rs.etf.pp1.symboltable.concepts.Obj;

public class MJParserTest {

	static {
		DOMConfigurator.configure(Log4JUtils.instance().findLoggerConfigFile());
		Log4JUtils.instance().prepareLogFile(Logger.getRootLogger());
	}
	
	public static void main(String[] args) throws Exception {
		
		Logger log = Logger.getLogger(MJParserTest.class);
		
		Reader br = null;
		try {
			//File sourceCode = new File("test/program.mj");
			if (args.length < 2) {
				log.error("Nema dovoljno argumenata u komandnoj liniji! Poziv: MJParser <source-file> <obj-file> ");
				return;
			}
			File sourceCode = new File(args[0]);
			if (!sourceCode.exists()) {
				log.error("Source file [" + sourceCode.getAbsolutePath() + "] not found!");
				return;
			}
			log.info("Compiling source file: " + sourceCode.getAbsolutePath());
			
			br = new BufferedReader(new FileReader(sourceCode));
			Yylex lexer = new Yylex(br);
			
			MJParser p = new MJParser(lexer);
	        Symbol s = p.parse();  //pocetak parsiranja
	        
			System.out.println(p.output);
	       
			log.info("Broj deklaracija globalnih promenljivih= " + p.globalVarsCount);
	        log.info("Definicije globalnih konstanti= " + p.globalConstDef);
	        log.info("Definicije lokalnih promenljivih (u f-ji main)= " + p.localVarsCount);
	        log.info("Deklaracije globalnih nizova= " + p.globalArrDecl);
	        log.info("Definicije statickih funkcija unutrasnjih klasa = " + p.staticInnerMethods);
	        log.info("Broj blokova naredbi= " + p.StatementBlocks);
	        log.info("Broj poziva funkcija u telu metode main = " + p.MainMethodCalls);
	        log.info("Broj deklaracija formalnih argumenata funkcija = " + p.FormalMethodArgs);

	        Tab.dump();
	        
	        if (!p.errorDetected) {
	        	File objFile = new File(args[1]);
	        	if (objFile.exists())
	        		objFile.delete();
	        	Code.write(new FileOutputStream(objFile));
	        	
	        	log.info("Parsiranje uspesno zavrseno!");
	        }
	        else {
	        	log.error("Parsiranje NIJE uspesno zavrseno!");
	        }
	        
		} 
		finally {
			if (br != null) try { br.close(); } catch (IOException e1) { log.error(e1.getMessage(), e1); }
		}

	}
	
	
}
