package classeAnnexe

import org.eclipse.emf.ecore.EClass
import fr.irisa.triskell.idm.EcoreLoader

class EcoreHelper {

	def static main(String[] args) {

		val helper = new EcoreHelper();
		var p = (new EcoreLoader).loadModel("Question1.ecore");
		var cls = p.EClassifiers.filter(EClass);

		// Flat
		println("\n ======  FLAT  ======= ");
		for (cl : cls) {
			println("-> Class " + cl.name + " [" + helper.setIdentifier(cl) + "] :");
			print(helper.flat(cl));
			println("\n----------------------------------------------");
		}

		// Short
		println("\n ======  SHORT =======   ");

		for (cl : cls) {
			println("-> Class " + cl.name + " [" + helper.setIdentifier(cl) + "] :");
			print(helper.getMembresInfo(cl));
			println("\n----------------------------------------------");
		}

		// FlatShort
		println("\n ======  FLATESHORT =======   ");

		for (cl : cls) {
			println("-> Class " + cl.name + " [" + helper.setIdentifier(cl) + "] :");
			print(helper.getMembresInfoWithParent(cl));
			println("\n----------------------------------------------");
		}
	}

	def String flat(EClass mm) {
		var out = "";

		//out = out + (mm.name + "\n");
		var parents = mm.ESuperTypes;

		var count = 1;
		for (pa : parents) {

			if (count == 1) {
				out = out + "\t its parents: \n";
			}
			out = out + ( "\t   " + count + ". " + pa.name + " [" + setIdentifier(pa) + "]" );
			count = count + 1;
		}

		return out;
	}

	// short
	def String getMembresInfo(EClass mm) {
		var out = "";

		//visit its attributes
		var atts = mm.EAllAttributes;
		var count = 1;
		for (a : atts) {
			if (count == 1) {
				out = out + "Its attributes are: \n";
			}
			out = out + "\t-- " + count + ". " + a.name + "\n";
			count = count + 1;
		}

		//visit its operations
		var opts = mm.EAllOperations;

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

	// flatShort
	def String getMembresInfoWithParent(EClass mm) {
		var out = "";
		var parent = mm.ESuperTypes;

		for (p : parent) {
			out = out + getMembresInfoWithParent(p);
		}

		//visit its attributes
		var atts = mm.EAllAttributes;

		var count = 1;
		for (a : atts) {
			if (count == 1) {
				out = out + "Its attributes are: \n";
			}
			out = out + "\t-- " + count + ". " + a.name + "\n";
			count = count + 1;
		}

		//visit its operations
		var opts = mm.EAllOperations;

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

	def String setIdentifier(EClass mm) {
		var id = mm.name.hashCode() + "_" + System.currentTimeMillis;
		return id;
	}

}
