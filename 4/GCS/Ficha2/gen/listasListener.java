// Generated from /home/d3/Documents/UM/4/GCS/Ficha2/src/listas.g4 by ANTLR 4.7
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link listasParser}.
 */
public interface listasListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link listasParser#lista}.
	 * @param ctx the parse tree
	 */
	void enterLista(listasParser.ListaContext ctx);
	/**
	 * Exit a parse tree produced by {@link listasParser#lista}.
	 * @param ctx the parse tree
	 */
	void exitLista(listasParser.ListaContext ctx);
	/**
	 * Enter a parse tree produced by {@link listasParser#elems}.
	 * @param ctx the parse tree
	 */
	void enterElems(listasParser.ElemsContext ctx);
	/**
	 * Exit a parse tree produced by {@link listasParser#elems}.
	 * @param ctx the parse tree
	 */
	void exitElems(listasParser.ElemsContext ctx);
	/**
	 * Enter a parse tree produced by {@link listasParser#elem}.
	 * @param ctx the parse tree
	 */
	void enterElem(listasParser.ElemContext ctx);
	/**
	 * Exit a parse tree produced by {@link listasParser#elem}.
	 * @param ctx the parse tree
	 */
	void exitElem(listasParser.ElemContext ctx);
}