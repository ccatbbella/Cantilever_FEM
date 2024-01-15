% Yixiao Yue, 01/14/2014

% Create a structural model
structural_model = createpde('structural', 'static-solid');

% Assign geometry of the strutural model
importGeometry(structural_model, 'cantileverTest.stl');

% Visualize the stl model
% pdegplot(structural_model, FaceLabels="on", FaceAlpha=0.5);

% Max element edge length is 0.01
mesh = generateMesh(structural_model, 'Hmax', 1);

% Visualize the mesh
pdeplot3D(structural_model);

% Material Properties
E = 227E9; % Units: Pa, Measures stiffness
nu = 0.27; % Dimesionless, Measures deformation
structuralProperties(structural_model, 'YoungsModulus', E, 'PoissonsRatio', nu);

% Specify boundary condition
structuralBC(structural_model, 'Face', 1, 'Constraint', 'fixed');
structuralBoundaryLoad(structural_model, 'Face', 7, 'Pressure', 5e5);
structuralBoundaryLoad(structural_model, 'Face', 9, 'Pressure', 6e5);

% Solve the pde & Visualize the results
Results = solve(structural_model);
pdeplot3D(structural_model, 'ColorMapData', Results.VonMisesStress, 'Deformation', Results.Displacement, 'DeformationScaleFactor', 100);


