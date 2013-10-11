package classeAnnexe

import fr.irisa.triskell.idm.EcoreLoader
import org.eclipse.emf.ecore.EClass
import static extension classeAnnexe.EclassAspect.*;

class Main {
	def static void main(String[] args) {

		var p = (new EcoreLoader).loadModel("Question1.ecore");
		var cls = p.EClassifiers.filter(EClass);

		// Flat
		println("\n ======  FLAT  ======= ");
		for (cl : cls) {
			println("-> Class " + cl.name + " [" + cl.setIdentifier() + "] :");
			print(cl.flat());
			println("\n----------------------------------------------");
		}

		// Short
		println("\n ======  SHORT =======   ");

		for (cl : cls) {
			println("-> Class " + cl.name + " [" + cl.setIdentifier() + "] :");
			print(cl.getMembresInfo());
			println("\n----------------------------------------------");
		}

		// FlatShort
		println("\n ======  FLATESHORT =======   ");

		for (cl : cls) {
			println("-> Class " + cl.name + " [" + cl.setIdentifier() + "] :");
			print(cl.getMembresInfoWithParent());
			println("\n----------------------------------------------");
		}
	
	
	}
}