// mainメソッドを含むPlotGraphTesterクラスを書く

class PlotGraphTester{

	public static void main(String args[]){
		
		PlotGraph virtPlotGraphs[] = {
			new PlotGraph('0'),
			new SinPGraph('1', 1, 1),
			new SawToothPGraph('2', 1, 1),
		};

		PlotGraph.clear();
		for(PlotGraph g : virtPlotGraphs) g.plot();
		PlotGraph.print();

		System.out.println("-----------------------------------------");

		((SinPGraph)virtPlotGraphs[1]).setAmplitude(2);
		((SawToothPGraph)virtPlotGraphs[2]).setPeriod(0.5);

		PlotGraph.clear();
		for(PlotGraph g : virtPlotGraphs) g.plot();
		PlotGraph.print();

	}

}

