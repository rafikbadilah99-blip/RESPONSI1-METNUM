%RAFIK BADILAH_L0325009
%RESPONSI 1_PRAKTIKUM METODE NUMERIK

% ==========================================
% KASUS 2: Sistem Persamaan Linear (SPL)
% ==========================================

% Matriks Koefisien A (dalam satuan kg)
% Kolom: [Beras, Telur, Tepung, Ayam]
A = [
    2.5 , 1.5  , 5.0 , 0.5;   % Adel
    4.0 , 0.75 , 1.0 , 2.0;   % Briza
    2.0 , 1.5  , 0.5 , 6.0;   % Caca
    1.0 , 4.25 , 2.0 , 0.9    % Dinda
];

% Vektor Hasil b (Total Belanja dalam Rp)
b = [161000; 149000; 251500; 173000];

fprintf('=== ANALISIS METODE KASUS 2 ===\n');
% Uji Dominansi Diagonal untuk Gauss-Seidel
n = size(A, 1);
is_diag_dom = true;
for i = 1:n
    sum_row = sum(abs(A(i,:))) - abs(A(i,i));
    if abs(A(i,i)) <= sum_row
        is_diag_dom = false;
    end
end

if is_diag_dom
    fprintf('Matriks dominan secara diagonal. Metode Gauss-Seidel BISA digunakan.\n');
else
    fprintf('Matriks TIDAK dominan secara diagonal.\n');
    fprintf('Guna menghindari ketiadaan konvergensi pada Gauss-Seidel, digunakan METODE GAUSS-JORDAN (Metode Langsung).\n\n');
end

% METODE ELIMINASI GAUSS-JORDAN
Aug = [A, b]; % Matriks Augmentasi

for i = 1:n
    % Pivotisasi
    Aug(i, :) = Aug(i, :) / Aug(i, i);

    % Eliminasi elemen di atas dan di bawah pivot
    for j = 1:n
        if j ~= i
            factor = Aug(j, i);
            Aug(j, :) = Aug(j, :) - factor * Aug(i, :);
        end
    end
end

x = Aug(:, end);

% Output Hasil
fprintf('=== HASIL HARGA PER KG ===\n');
fprintf('Harga Beras / kg  : Rp %.2f\n', x(1));
fprintf('Harga Telur / kg  : Rp %.2f\n', x(2));
fprintf('Harga Tepung / kg : Rp %.2f\n', x(3));
fprintf('Harga Ayam / kg   : Rp %.2f\n', x(4));
