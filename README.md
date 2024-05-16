# Praktikum B
Hier werden die Messdaten sowie Protokolle von unseren Laborversuchen im [Praktikum B der Universität zu Köln](https://physik.uni-koeln.de/index.php?id=617) des Bachelor-Studienganges der Physik zur Verfügung gestellt.

Bei einigen Versuchen ist Code in Form von [Jupyter](https://jupyter.org)-Notebooks zur Verfügung gestellt. Einige davon nutzen [Python 3](https://www.python.org), andere [Julia](https://julialang.org).

## 1. Atom- & Molekülphysik
* B1.1: Infrarotabsorption in $\ce{CO_2}$ ([PDF](./B1.1/B1.1.pdf), [LaTeX](./B1.1/B1.1.tex))

## 2. Festkörperphysik
* B2.4: Magnetisierung eines Ferrits ([PDF](./B2.4/B2.4.pdf), [LaTeX](./B2.4/B2.4.tex))
	* Lernkarten ([PDF](./B2.4/B2.4_Lernkarten.pdf), [LaTeX](./B2.4/B2.4_Lernkarten.tex))
	* Auswertung (Python) ([Jupyter](./B2.4/data/Auswertung.ipynb), [PDF](./B2.4/data/Auswertung.pdf))
* B2.5: Rastertunnelmikroskopie ([PDF](./B2.5/B2.5.pdf), [LaTeX](./B2.5/B2.5.tex))
	* Auswertung (Python) ([Jupyter](./B2.5/data/Austrittsarbeit/Auswertung.ipynb), [PDF](./B2.5/data/Austrittsarbeit/Auswertung.pdf))
* B2.8: Versetzungen in Lithiumfluorid ([PDF](./B2.8/B2.8.pdf), [LaTeX](./B2.8/B2.8.tex))

## 3. Kernphysik
* B3.1: Statistik der Kernzerfälle ([PDF](./B3.1/B3.1.pdf), [LaTeX](./B3.1/B3.1.tex))
* B3.3: Reichweite von Alphastrahlung ([PDF](./B3.3/B3.3.pdf), [LaTeX](./B3.3/B3.3.tex))
	* Lernkarten ([PDF](./B3.3/B3.3_Lernkarten.pdf), [LaTeX](./B3.3/B3.3_Lernkarten.tex))
	* Auswertung (Julia) ([Jupyter](./B3.3/data/Auswertung.ipynb), [PDF](./B3.3/data/Auswertung.pdf))
* B3.4: Positronen-Emissions-Tomographie (PET) ([PDF](./B3.4/B3.4.pdf), [LaTeX](./B3.4/B3.4.tex))

# Jupyter
## Python

```shell
pip3 install jupyterlab pandas seaborn scipy
jupyter notebook
```

## Julia
```shell
julia -e 'import Pkg; Pkg.add(["CSV", "IJulia", "Plots", "LaTeXStrings"])'
julia -e 'using IJulia; notebook(dir=".", detached=true)'
```
