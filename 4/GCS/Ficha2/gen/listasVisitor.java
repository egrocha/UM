// Generated from /home/d3/Documents/UM/4/GCS/Ficha2/src/listas.g4 by ANTLR 4.7
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link listasParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface listasVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link listasParser#lista}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLista(listasParser.ListaContext ctx);
	/**
	 * Visit a parse tree produced by {@link listasParser#elems}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElems(listasParser.ElemsContext ctx);
	/**
	 * Visit a parse tree produced by {@link listasParser#elem}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElem(listasParser.ElemContext ctx);
}