package classeAnnexe

import fr.inria.triskell.k3.Aspect
import org.eclipse.emf.ecore.EClass
import static extension classeAnnexe.EclassAspect.*;

@Aspect(className=typeof(EClass))
class EclassAspect {

	def String flat() {
		var out = "";

		//out = out + (mm.name + "\n");
		var parents = _self.ESuperTypes;

		var count = 1;
		for (pa : parents) {

			if (count == 1) {
				out = out + "\t its parents: \n";
			}
			out = out + ( "\t   " + count + ". " + pa.name + " [" + _self.setIdentifier() + "]" );
			count = count + 1;
		}

		return out;
	}

	def String getMembresInfo() {
		var out = "";

		//visit its attributes
		var atts = _self.EAllAttributes;
		var count = 1;
		for (a : atts) {
			if (count == 1) {
				out = out + "Its attributes are: \n";
			}
			out = out + "\t-- " + count + ". " + a.name + "\n";
			count = count + 1;
		}

		//visit its operations
		var opts = _self.EAllOperations;

		count = 1;
		for (op : opts) {
			if (count == 1) {
				out = out + "Its functions are: \n";
			}
			out = out + "\t-- " + count + ". " + op.name;
			count = count + 1;
		}
		return out;
	}

	def String getMembresInfoWithParent() {
		var out = "";
		var parent = _self.ESuperTypes;

		for (p : parent) {
			out = out + p.getMembresInfoWithParent();
		}

		//visit its attributes
		var atts = _self.EAttributes;

		var count = 1;
		for (a : atts) {
			if (count == 1) {
				out = out + "Its attributes are: \n";
			}
			out = out + "\t-- " + count + ". " + a.name + "\n";
			count = count + 1;
		}

		//visit its operations
		var opts = _self.EOperations;

		count = 1;
		for (op : opts) {

			if (count == 1) {
				out = out + "Its functions are: \n";
			}

			out = out + "\t-- " + count + ". " + op.name;
			count = count + 1;
		}
		return out;
	}

	def String setIdentifier() {
		var id = _self.name.hashCode() + "_" + System.currentTimeMillis;
		return id;
	}
	
	
}
