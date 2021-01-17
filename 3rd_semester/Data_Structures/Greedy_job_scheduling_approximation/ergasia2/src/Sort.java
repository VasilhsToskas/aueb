public class Sort {


    private static int[] aux;

    static int min(int A, int B) {
        return (A < B) ? A : B;
    }

    public static int[] mergesort(int[] a, int p, int r) {
        if (r <= p) return null;
        aux = new int[a.length];
        for (int m = 1; m <= r - p; m = m + m) {
            for (int i = p; i <= r - m; i += m + m) {
                merge(a, i, i + m - 1, min(i + m + m - 1, r));
            }
        }
        return (a);
    }

    static void merge(int[] a, int p, int m, int r) {
        int i, j;
        for (i = m + 1; i > p; i--) {
            aux[i - 1] = a[i - 1];
        }
        for (j = m; j < r; j++) {
            aux[j + 1] = a[r + m - j];
        }
        for (int k = p; k <= r; k++) {
            if (aux[j] > aux[i]) {
                a[k] = aux[j--];
            } else {
                a[k] = aux[i++];
            }
        }

    }

}
