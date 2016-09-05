package rs.ac.bg.etf.pp1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.apache.log4j.Logger;

import java_cup.runtime.Symbol;

public class MJParseTest {

	public static void main(String[] args) throws Exception{
		Logger log = Logger.getLogger(MJParseTest.class);
		Reader br = null;
		try{
			File sourceCode = new File("test/program.mj");
			log.info("Compiling source file:" + sourceCode.getAbsolutePath());
			br = new BufferedReader(new FileReader(sourceCode));
			Yylex lexer = new Yylex (br);
			MJParser p = new MJParser(lexer);
			Symbol s= p.parse();
		}
		finally{
			if(br!= null) try{
				br.close();
			}catch (IOException e1){
				log.error(e1.getMessage(), e1);
			}
		}
	}
}
