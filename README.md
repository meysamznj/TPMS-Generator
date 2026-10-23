# TPMS Generator

[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![GUI PyQt6](https://img.shields.io/badge/GUI-PyQt6-green.svg)](https://www.riverbankcomputing.com/software/pyqt/)
[![Rendering PyVista](https://img.shields.io/badge/3D-PyVista%20%7C%20VTK-red.svg)](https://pyvista.org/)
[![Kernel Manifold3D](https://img.shields.io/badge/CSG-Manifold3D-orange.svg)](https://github.com/elalish/manifold)
[![Offline](https://img.shields.io/badge/Network-100%25%20Offline-success.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**TPMS Generator** is a standalone, desktop CAD application for generating, analyzing, visualizing, and exporting **Triply Periodic Minimal Surface (TPMS)** lattice metamaterials. 

Designed for mechanical engineers, materials scientists, and additive manufacturing researchers, the software pairs exact mathematical implicit surface modeling with the modern **Manifold3D** Constructive Solid Geometry (CSG) kernel to guarantee **100% watertight, manifold, 3D-printable meshes** suitable for direct physical fabrication and FEA/CFD numerical simulations (COMSOL Multiphysics, ANSYS, Abaqus).

---

## 📸 Key Capabilities & Architecture

```
┌─────────────────────────────────┐     ┌──────────────────────────────────┐
│   Implicit Mathematical Field   │ ──> │      Marching Cubes Engine       │
│  F(x,y,z) on Vectorized Grid    │     │  Dual-Isosurface (+tau and -tau) │
└─────────────────────────────────┘     └──────────────────────────────────┘
                                                          │
                                                          ▼
┌─────────────────────────────────┐     ┌──────────────────────────────────┐
│   Watertight Binary STL Export  │ <── │   Manifold3D Exact CSG Kernel    │
│    (3D Printing & FEA Ready)    │     │ Boundary Clipping (Box/Cyl/Sph)  │
└─────────────────────────────────┘     └──────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐     ┌──────────────────────────────────┐
│  Hardware OpenGL 3D Viewport    │     │ Topology-Preserving Decimation   │
│ (PyVistaQt, PBR & Flat Shading) │     │ (Normal Consistency & QEM Metric)│
└─────────────────────────────────┘     └──────────────────────────────────┘
```

- **Dual Morphological Modes**:
  - **Sheet-Based TPMS**: Uniform solid wall thickness ($t > 0$) or zero-thickness base sheet ($t = 0$).
  - **Skeletal-Based TPMS**: Solid network filling one of the interpenetrating labyrinthine pore domains via level-set cutoff parameter $c$.
- **Parametric Boundary Envelopes**:
  - **Rectangular Prism (Box)**: $L_x \times L_y \times L_z$ with precision planar face clipping.
  - **Cylinder**: Parametric radius $R$ and height $H$, with planar top/bottom caps.
  - **Sphere**: Enclosed spherical boundary of radius $R$.
- **Real-Time Physical & Metamaterial Metrics**:
  - Automated calculation of **Porosity percentage ($\%$)**, **Solid Volume ($\text{cm}^3$)**, **Envelope Volume ($\text{cm}^3$)**, **Total Surface Area ($\text{cm}^2$)**, and **Specific Surface Area ratio ($\text{m}^2/\text{m}^3$)**.
- **Interactive 3D Viewport**:
  - Powered by PyVistaQt / VTK Core Profile with direct OpenGL hardware acceleration.
  - Studio lighting rig with ambient/diffuse/specular controls, flat faceted CAD shading, smooth PBR shading, coordinate axes, and dark wireframe overlays.
- **Topology-Preserving Mesh Optimization**:
  - In-app Quadric Error Metric (QEM) decimation with strict normal orientation enforcement and face-winding validation to prevent surface defects in downstream CAE tools.
- **Zero External Network Dependencies**:
  - Runs 100% locally on any machine with complete operational privacy.

---

## 📐 Mathematical Equations & TPMS Families

The studio features 6 analytical TPMS families alongside an **Arbitrary Custom Equation Parser**:

### 1. Gyroid (Schoen G)
$$\sin\left(\frac{2\pi x}{p}\right)\cos\left(\frac{2\pi y}{p}\right) + \sin\left(\frac{2\pi y}{p}\right)\cos\left(\frac{2\pi z}{p}\right) + \sin\left(\frac{2\pi z}{p}\right)\cos\left(\frac{2\pi x}{p}\right) = 0$$

### 2. Gyroid 2 (Alternate Chiral Configuration)
$$\sin\left(\frac{2\pi y}{p}\right)\cos\left(\frac{2\pi x}{p}\right) + \sin\left(\frac{2\pi x}{p}\right)\cos\left(\frac{2\pi z}{p}\right) + \sin\left(\frac{2\pi z}{p}\right)\cos\left(\frac{2\pi y}{p}\right) = 0$$

### 3. Diamond (Schwarz D)
$$\sin(kx)\sin(ky)\sin(kz) + \cos(kx)\cos(ky)\sin(kz) + \cos(ky)\sin(kx)\cos(kz) + \cos(kz)\sin(ky)\cos(kx) = 0$$
*(where $k = 2\pi / p$)*

### 4. Primitive (Schwarz P)
$$\cos\left(\frac{2\pi x}{p}\right) + \cos\left(\frac{2\pi y}{p}\right) + \cos\left(\frac{2\pi z}{p}\right) = 0$$

### 5. I-WP (Schoen I-WP)
$$2\left[\cos(kx)\cos(ky) + \cos(ky)\cos(kz) + \cos(kz)\cos(kx)\right] - \left[\cos(2kx) + \cos(2ky) + \cos(2kz)\right] = 0$$

### 6. Lidinoid
$$\frac{1}{2} \Big[ \sin(2kx)\cos(ky)\sin(kz) + \sin(2ky)\cos(kz)\sin(kx) + \sin(2kz)\cos(kx)\sin(ky) \Big] - \frac{1}{2} \Big[ \cos(2kx)\cos(2ky) + \cos(2ky)\cos(2kz) + \cos(2kz)\cos(2kx) \Big] = 0$$

### 7. Custom Equation Parser
Enter any symbolic formula $f(x, y, z) = 0$ using `x, y, z, p, k` and standard mathematical functions (`sin`, `cos`, `tan`, `sqrt`, `exp`, `log`, `abs`, etc.). Supports MATLAB function syntax, Python expressions, and textbook mathematical notation.

---

## ⚡ Quick Start: Zero-Installation Executable

For end-users and researchers who do not want to manage Python virtual environments:

1. Go to the [**Releases**](../../releases) tab of this repository.
2. Download **`TPMS_Generator.exe`**.
3. Double-click to launch immediately. No installation, Python interpreter, or administrative privileges required.

---

## 💻 Source Code Installation & Execution

### Prerequisites
- Python 3.9, 3.10, 3.11, or 3.12 (64-bit recommended)

```bash
# 1. Clone the repository
git clone https://github.com/your-username/tpms-generator.git
cd tpms-generator

# 2. Install dependencies
pip install -r requirements.txt
```

### Required Packages
- `PyQt6` (Desktop UI framework)
- `numpy` & `scipy` (Numerical array operations & spatial data structures)
- `scikit-image` (Isosurface Marching Cubes)
- `trimesh` (Triangular mesh data structures & file I/O)
- `manifold3d` (Fast C++ Constructive Solid Geometry kernel)
- `pyvista` & `pyvistaqt` (Hardware OpenGL 3D visualization)

### Running on Windows
- **One-Click Auto-Setup Launcher**: Double-click `run_python.bat`. It will automatically check for missing packages, install them via `pip` if needed, and start the GUI.
- **Silent Launch (Zero Console)**: Double-click `app.pyw`.
- **Command Prompt / PowerShell**:
  ```cmd
  python app.py
  ```

### Running on Linux / macOS
```bash
chmod +x run_python.sh
./run_python.sh
```

---

## 🔬 Best Practices for FEA & CFD Simulation (COMSOL Multiphysics / ANSYS)

When importing thin-walled TPMS geometries ($t \le 0.50\text{ mm}$) into finite element or computational fluid dynamics software:

1. **Direct High-Fidelity Generation**:
   The gold standard for simulation accuracy is setting your desired target resolution directly via the **Computational Resolution (`grid_res`)** parameter (e.g. `0.35 mm` to `0.45 mm`). This guarantees uniform wall thickness throughout the entire domain without geometric distortion.
2. **Importing Decimated STL Meshes into COMSOL**:
   - In COMSOL's **Geometry > Import** node, **uncheck (disable) `Simplify mesh`**.
   - *Technical Rationale*: When a mesh is already optimized in TPMS Generator, enabling a secondary `Simplify mesh` pass inside COMSOL applies a blind relative tolerance ($\sim 1\%$ of bounding box). On thin walls, this tolerance exceeds the wall thickness, causing the opposing inner and outer surfaces to collapse into each other.
   - Keep **`Form Solids`** enabled. The exported STL is manifold, oriented, and watertight, allowing COMSOL to convert the boundary mesh directly into a clean Solid Domain.

---

## 🛠️ Building a Standalone Executable (.exe)

To compile the entire codebase into a self-contained `.exe` binary:

```cmd
# Double-click build_exe.bat or run:
pip install pyinstaller
python -m PyInstaller --noconsole --onefile --icon=icon.ico --collect-all pyvista --collect-all pyvistaqt --collect-all manifold3d --name "TPMS_Generator" --clean app.py
```
The resulting binary will be placed inside `dist/TPMS_Generator.exe`.

## 👤 Author & Academic Profile

**Meysam Naderi**  
*Specialist in Computational Fluid Dynamics (CFD), Transport Phenomena & Numerical Simulation*  

- 💼 **LinkedIn**: [linkedin.com/in/meysam-naderi-cfd](https://www.linkedin.com/in/meysam-naderi-cfd/)
- ✉️ **Contact**: [meysam.nederi@gmail.com](mailto:meysam.nederi@gmail.com)

If you use this software in academic research, journal publications, or CFD/FEA engineering workflows, please feel free to connect or cite this project.

---

## 📄 License
This project is licensed under the **MIT License** — free for academic, personal, and commercial research.
