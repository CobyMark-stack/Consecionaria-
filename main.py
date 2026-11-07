
import tkinter as tk
from tkinter import ttk, messagebox
from decimal import Decimal, InvalidOperation
from datetime import date
import psycopg

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "dbname": "concesionaria",
    "user": "postgres",
    "password": "1234",
}


def conectar():
    return psycopg.connect(**DB_CONFIG)


class ConcesionariaApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Concesionaria | Sistema de gestión")
        self.root.geometry("1350x760")
        self.root.minsize(1000, 600)

        self.auto_id = None
        self.cliente_id = None
        self.sucursal_id = None
        self.vendedor_id = None

        self.crear_interfaz()
        self.actualizar_todo()

    # ---------------- INTERFAZ GENERAL ----------------

    def crear_interfaz(self):
        encabezado = ttk.Frame(self.root, padding=12)
        encabezado.pack(fill="x")

        ttk.Label(
            encabezado,
            text="SISTEMA DE GESTIÓN DE CONCESIONARIA",
            font=("Segoe UI", 18, "bold")
        ).pack(anchor="w")

        ttk.Label(
            encabezado,
            text="Inventario | Ventas | Clientes | Sucursales | Vendedores"
        ).pack(anchor="w")

        ttk.Button(
            encabezado,
            text="Actualizar todo",
            command=self.actualizar_todo
        ).pack(anchor="e")

        self.nb = ttk.Notebook(self.root)
        self.nb.pack(fill="both", expand=True, padx=10, pady=8)

        self.ta = ttk.Frame(self.nb, padding=8)
        self.tv = ttk.Frame(self.nb, padding=8)
        self.tc = ttk.Frame(self.nb, padding=8)
        self.ts = ttk.Frame(self.nb, padding=8)
        self.tvend = ttk.Frame(self.nb, padding=8)

        self.nb.add(self.ta, text="Inventario")
        self.nb.add(self.tv, text="Ventas")
        self.nb.add(self.tc, text="Clientes")
        self.nb.add(self.ts, text="Sucursales")
        self.nb.add(self.tvend, text="Vendedores")

        self.interfaz_autos()
        self.interfaz_ventas()
        self.interfaz_clientes()
        self.interfaz_sucursales()
        self.interfaz_vendedores()

    def tabla(self, padre, columnas, encabezados, anchos=None):
        marco = ttk.Frame(padre)
        marco.pack(fill="both", expand=True)

        tabla = ttk.Treeview(
            marco, columns=columnas, show="headings",
            selectmode="browse"
        )

        for c in columnas:
            tabla.heading(c, text=encabezados.get(c, c))
            tabla.column(c, width=(anchos or {}).get(c, 130),
                         minwidth=60, anchor="w")

        sy = ttk.Scrollbar(marco, orient="vertical",
                           command=tabla.yview)
        sx = ttk.Scrollbar(marco, orient="horizontal",
                           command=tabla.xview)

        tabla.configure(yscrollcommand=sy.set, xscrollcommand=sx.set)
        tabla.grid(row=0, column=0, sticky="nsew")
        sy.grid(row=0, column=1, sticky="ns")
        sx.grid(row=1, column=0, sticky="ew")

        marco.rowconfigure(0, weight=1)
        marco.columnconfigure(0, weight=1)
        return tabla

    def rellenar(self, tabla, filas):
        tabla.delete(*tabla.get_children())
        for fila in filas:
            tabla.insert(
                "", "end",
                values=tuple("" if v is None else str(v) for v in fila)
            )

    def consultar(self, sql, params=()):
        with conectar() as conn:
            with conn.cursor() as cur:
                cur.execute(sql, params)
                return cur.fetchall()

    def ejecutar(self, sql, params=(), devolver=False):
        with conectar() as conn:
            with conn.cursor() as cur:
                cur.execute(sql, params)
                if devolver:
                    return cur.fetchone()
                return cur.rowcount

    def error(self, titulo, exc):
        messagebox.showerror(titulo, str(exc))

    def actualizar_todo(self):
        self.cargar_autos()
        self.cargar_ventas()
        self.cargar_clientes()
        self.cargar_sucursales()
        self.cargar_vendedores()
        self.cargar_listas_venta()

    # ---------------- INVENTARIO ----------------

    def interfaz_autos(self):
        barra = ttk.Frame(self.ta)
        barra.pack(fill="x", pady=5)

        self.busqueda_auto = tk.StringVar()
        ttk.Label(barra, text="Buscar:").pack(side="left")
        entrada = ttk.Entry(barra, textvariable=self.busqueda_auto)
        entrada.pack(side="left", padx=6)
        entrada.bind("<KeyRelease>", lambda e: self.cargar_autos())

        ttk.Button(barra, text="Actualizar",
                   command=self.cargar_autos).pack(side="left")

        cols = ("id", "marca", "modelo", "anio", "version", "color",
                "serie", "motor", "placas", "precio")
        heads = {
            "id": "ID", "marca": "Marca", "modelo": "Modelo",
            "anio": "Año", "version": "Versión", "color": "Color",
            "serie": "Número de serie", "motor": "Número de motor",
            "placas": "Placas", "precio": "Precio"
        }
        self.tabla_auto = self.tabla(self.ta, cols, heads)
        self.tabla_auto.bind("<<TreeviewSelect>>", self.sel_auto)

        form = ttk.LabelFrame(self.ta, text="Datos del automóvil",
                              padding=8)
        form.pack(fill="x", pady=8)

        nombres = [
            ("Marca", "marca"), ("Modelo", "modelo"),
            ("Año", "anio"), ("Versión", "version"),
            ("Color", "color"), ("Número de serie", "serie"),
            ("Número de motor", "motor"), ("Placas", "placas"),
            ("Precio", "precio")
        ]
        self.auto_vars = {k: tk.StringVar() for _, k in nombres}

        for i, (titulo, clave) in enumerate(nombres):
            f, c = divmod(i, 5)
            ttk.Label(form, text=titulo).grid(
                row=f * 2, column=c, sticky="w", padx=4
            )
            ttk.Entry(form, textvariable=self.auto_vars[clave],
                       width=22).grid(
                row=f * 2 + 1, column=c, sticky="ew", padx=4, pady=3
            )
            form.columnconfigure(c, weight=1)

        botones = ttk.Frame(self.ta)
        botones.pack(fill="x")

        ttk.Button(botones, text="Agregar",
                   command=self.agregar_auto).pack(side="left", padx=3)
        ttk.Button(botones, text="Guardar cambios",
                   command=self.modificar_auto).pack(side="left", padx=3)
        ttk.Button(botones, text="Eliminar",
                   command=self.eliminar_auto).pack(side="left", padx=3)
        ttk.Button(botones, text="Limpiar",
                   command=self.limpiar_auto).pack(side="left", padx=3)

    def cargar_autos(self):
        if not hasattr(self, "tabla_auto"):
            return
        try:
            termino = self.busqueda_auto.get().strip()
            sql = """
                SELECT id, marca, modelo, año, version, color,
                       num_ser, num_mot, num_pla, precio
                FROM auto
            """
            if termino:
                patron = f"%{termino}%"
                sql += """
                    WHERE marca ILIKE %s OR modelo ILIKE %s
                    OR CAST(año AS TEXT) ILIKE %s
                    OR COALESCE(version,'') ILIKE %s
                    OR color ILIKE %s OR num_ser ILIKE %s
                    OR num_mot ILIKE %s
                    OR COALESCE(num_pla,'') ILIKE %s
                    OR CAST(precio AS TEXT) ILIKE %s
                """
                filas = self.consultar(sql + " ORDER BY id",
                                       (patron,) * 9)
            else:
                filas = self.consultar(sql + " ORDER BY id")
            self.rellenar(self.tabla_auto, filas)
        except Exception as exc:
            self.error("Error al cargar inventario", exc)

    def sel_auto(self, _event=None):
        sel = self.tabla_auto.selection()
        if not sel:
            return
        v = self.tabla_auto.item(sel[0], "values")
        self.auto_id = int(v[0])
        claves = ["marca", "modelo", "anio", "version", "color",
                  "serie", "motor", "placas", "precio"]
        for k, valor in zip(claves, v[1:]):
            self.auto_vars[k].set(valor)

    def datos_auto(self):
        d = {k: v.get().strip() for k, v in self.auto_vars.items()}
        obligatorios = ["marca", "modelo", "anio", "color",
                        "serie", "motor", "precio"]
        if any(not d[k] for k in obligatorios):
            messagebox.showwarning(
                "Datos incompletos",
                "Completa marca, modelo, año, color, serie, motor y precio."
            )
            return None
        try:
            anio = int(d["anio"])
            if not 1886 <= anio <= 2100:
                raise ValueError
            precio = Decimal(d["precio"].replace(",", ""))
            if not precio.is_finite() or precio < 0:
                raise ValueError
        except (ValueError, InvalidOperation):
            messagebox.showwarning(
                "Datos inválidos", "Revisa el año y el precio."
            )
            return None
        if len(d["serie"]) > 50:
            messagebox.showwarning(
                "Número de serie", "Máximo 50 caracteres."
            )
            return None
        return (
            d["marca"], d["modelo"], anio, d["version"] or None,
            d["color"], d["serie"], d["motor"], d["placas"] or None,
            precio
        )

    def agregar_auto(self):
        datos = self.datos_auto()
        if datos is None:
            return
        try:
            fila = self.ejecutar("""
                INSERT INTO auto
                (marca, modelo, año, version, color, num_ser, num_mot,
                 num_pla, precio)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s) RETURNING id
            """, datos, True)
            self.limpiar_auto()
            self.cargar_autos()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", f"Auto registrado. ID: {fila[0]}")
        except Exception as exc:
            self.error("No se pudo agregar el auto", exc)

    def modificar_auto(self):
        if self.auto_id is None:
            messagebox.showwarning("Selecciona un auto",
                                   "Selecciona un registro primero.")
            return
        datos = self.datos_auto()
        if datos is None:
            return
        if not messagebox.askyesno("Confirmar", "¿Guardar los cambios?"):
            return
        try:
            n = self.ejecutar("""
                UPDATE auto SET marca=%s, modelo=%s, año=%s, version=%s,
                color=%s, num_ser=%s, num_mot=%s, num_pla=%s, precio=%s
                WHERE id=%s
            """, (*datos, self.auto_id))
            self.cargar_autos()
            self.cargar_ventas()
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Resultado", "Cambios guardados." if n
                                else "No se encontró el auto.")
        except Exception as exc:
            self.error("No se pudo modificar el auto", exc)

    def eliminar_auto(self):
        if self.auto_id is None:
            messagebox.showwarning("Selecciona un auto",
                                   "Selecciona un registro primero.")
            return
        if not messagebox.askyesno(
            "Confirmar eliminación",
            "¿Eliminar este auto? Si tiene una venta relacionada, "
            "PostgreSQL puede impedirlo."
        ):
            return
        try:
            self.ejecutar("DELETE FROM auto WHERE id=%s", (self.auto_id,))
            self.limpiar_auto()
            self.cargar_autos()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Auto eliminado.")
        except Exception as exc:
            self.error("No se pudo eliminar el auto", exc)

    def limpiar_auto(self):
        self.auto_id = None
        for v in self.auto_vars.values():
            v.set("")
        for item in self.tabla_auto.selection():
            self.tabla_auto.selection_remove(item)

    # ---------------- VENTAS ----------------

    def interfaz_ventas(self):
        form = ttk.LabelFrame(self.tv, text="Registrar venta", padding=8)
        form.pack(fill="x", pady=5)

        self.venta_auto = tk.StringVar()
        self.venta_cliente = tk.StringVar()
        self.venta_vendedor = tk.StringVar()
        self.venta_monto = tk.StringVar()
        self.venta_pago = tk.StringVar(value="Contado")

        campos = [
            ("Auto disponible", self.venta_auto),
            ("Cliente", self.venta_cliente),
            ("Vendedor", self.venta_vendedor),
            ("Monto", self.venta_monto),
            ("Forma de pago", self.venta_pago)
        ]
        self.combo_venta = {}

        for i, (titulo, var) in enumerate(campos):
            ttk.Label(form, text=titulo).grid(
                row=0, column=i, sticky="w", padx=4
            )
            if i < 3:
                combo = ttk.Combobox(
                    form, textvariable=var, width=25, state="readonly"
                )
                combo.grid(row=1, column=i, padx=4, pady=4, sticky="ew")
                self.combo_venta[titulo] = combo
            elif i == 4:
                combo = ttk.Combobox(
                    form, textvariable=var, width=18,
                    values=("Contado", "Crédito", "Transferencia",
                            "Tarjeta", "Financiamiento"),
                    state="readonly"
                )
                combo.grid(row=1, column=i, padx=4, pady=4)
            else:
                ttk.Entry(form, textvariable=var, width=18).grid(
                    row=1, column=i, padx=4, pady=4
                )

        ttk.Button(form, text="Registrar venta",
                   command=self.registrar_venta).grid(
            row=2, column=0, padx=4, pady=6, sticky="w"
        )

        ttk.Button(form, text="Actualizar",
                   command=self.cargar_ventas).grid(
            row=2, column=1, padx=4, pady=6, sticky="w"
        )

        cols = ("id", "fecha", "auto", "cliente", "vendedor", "monto", "pago")
        heads = {
            "id": "ID", "fecha": "Fecha", "auto": "Automóvil",
            "cliente": "Cliente", "vendedor": "Vendedor",
            "monto": "Monto", "pago": "Forma de pago"
        }
        self.tabla_venta = self.tabla(self.tv, cols, heads)

        ttk.Button(self.tv, text="Eliminar venta seleccionada",
                   command=self.eliminar_venta).pack(anchor="w", pady=6)

    def cargar_listas_venta(self):
        if not hasattr(self, "combo_venta"):
            return
        try:
            autos = self.consultar("""
                SELECT a.id, a.marca, a.modelo, a.año
                FROM auto a
                WHERE NOT EXISTS (
                    SELECT 1 FROM venta ve WHERE ve.id_auto = a.id
                )
                ORDER BY a.marca, a.modelo
            """)
            clientes = self.consultar("""
                SELECT id, nombre, apellido FROM cliente
                ORDER BY apellido, nombre
            """)
            vendedores = self.consultar("""
                SELECT id, nombre, apellido FROM vendedor
                ORDER BY apellido, nombre
            """)

            self.mapa_autos = {
                f"{r[0]} | {r[1]} {r[2]} ({r[3]})": r[0] for r in autos
            }
            self.mapa_clientes = {
                f"{r[0]} | {r[1]} {r[2]}": r[0] for r in clientes
            }
            self.mapa_vendedores = {
                f"{r[0]} | {r[1]} {r[2]}": r[0] for r in vendedores
            }

            self.combo_venta["Auto disponible"]["values"] = list(
                self.mapa_autos
            )
            self.combo_venta["Cliente"]["values"] = list(
                self.mapa_clientes
            )
            self.combo_venta["Vendedor"]["values"] = list(
                self.mapa_vendedores
            )
        except Exception as exc:
            self.error("Error al cargar listas de venta", exc)

    def cargar_ventas(self):
        if not hasattr(self, "tabla_venta"):
            return
        try:
            filas = self.consultar("""
                SELECT ve.id, ve.fecha_ven,
                       a.marca || ' ' || a.modelo,
                       c.nombre || ' ' || c.apellido,
                       v.nombre || ' ' || v.apellido,
                       ve.monto_fin, ve.forma_pag
                FROM venta ve
                JOIN auto a ON a.id=ve.id_auto
                JOIN cliente c ON c.id=ve.id_cliente
                JOIN vendedor v ON v.id=ve.id_vendedor
                ORDER BY ve.fecha_ven DESC
            """)
            self.rellenar(self.tabla_venta, filas)
        except Exception as exc:
            self.error("Error al cargar ventas", exc)

    def registrar_venta(self):
        auto = self.mapa_autos.get(self.venta_auto.get())
        cliente = self.mapa_clientes.get(self.venta_cliente.get())
        vendedor = self.mapa_vendedores.get(self.venta_vendedor.get())
        monto = self.venta_monto.get().strip().replace(",", "")
        pago = self.venta_pago.get().strip()

        if not all([auto, cliente, vendedor, monto, pago]):
            messagebox.showwarning(
                "Datos incompletos",
                "Selecciona auto, cliente y vendedor; indica monto y pago."
            )
            return
        try:
            importe = Decimal(monto)
            if not importe.is_finite() or importe < 0:
                raise ValueError
        except (ValueError, InvalidOperation):
            messagebox.showwarning("Monto inválido",
                                   "Escribe un monto numérico válido.")
            return

        if not messagebox.askyesno("Confirmar venta",
                                  "¿Registrar esta venta?"):
            return
        try:
            # La transacción verifica nuevamente que el auto siga disponible.
            with conectar() as conn:
                with conn.cursor() as cur:
                    cur.execute(
                        "SELECT id FROM auto WHERE id=%s FOR UPDATE",
                        (auto,)
                    )
                    if cur.fetchone() is None:
                        raise ValueError("El auto ya no existe.")
                    cur.execute(
                        "SELECT 1 FROM venta WHERE id_auto=%s", (auto,)
                    )
                    if cur.fetchone():
                        raise ValueError("El auto ya tiene una venta.")
                    cur.execute("""
                        INSERT INTO venta
                        (id_auto, id_cliente, id_vendedor, fecha_ven,
                         monto_fin, forma_pag)
                        VALUES (%s,%s,%s,%s,%s,%s)
                    """, (auto, cliente, vendedor, date.today(),
                          importe, pago))
            self.venta_monto.set("")
            self.venta_auto.set("")
            self.cargar_ventas()
            self.cargar_autos()
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Venta registrada.")
        except Exception as exc:
            self.error("No se pudo registrar la venta", exc)

    def eliminar_venta(self):
        sel = self.tabla_venta.selection()
        if not sel:
            messagebox.showwarning("Selecciona una venta",
                                   "Selecciona una venta de la tabla.")
            return
        venta_id = self.tabla_venta.item(sel[0], "values")[0]
        if not messagebox.askyesno(
            "Confirmar", f"¿Eliminar la venta con ID {venta_id}?"
        ):
            return
        try:
            self.ejecutar("DELETE FROM venta WHERE id=%s", (venta_id,))
            self.cargar_ventas()
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Venta eliminada.")
        except Exception as exc:
            self.error("No se pudo eliminar la venta", exc)

    # ---------------- CLIENTES ----------------

    def interfaz_clientes(self):
        form = ttk.LabelFrame(self.tc, text="Datos del cliente", padding=8)
        form.pack(fill="x", pady=5)

        nombres = [
            ("Nombre", "nombre"), ("Apellido", "apellido"),
            ("CURP", "curp"), ("RFC", "rfc"),
            ("Fecha nacimiento (AAAA-MM-DD)", "fecha"),
            ("Estado civil", "civil")
        ]
        self.cli_vars = {k: tk.StringVar() for _, k in nombres}

        for i, (titulo, clave) in enumerate(nombres):
            f, c = divmod(i, 3)
            ttk.Label(form, text=titulo).grid(
                row=f * 2, column=c, sticky="w", padx=4
            )
            ttk.Entry(form, textvariable=self.cli_vars[clave],
                      width=30).grid(
                row=f * 2 + 1, column=c, sticky="ew", padx=4, pady=3
            )
            form.columnconfigure(c, weight=1)

        botones = ttk.Frame(self.tc)
        botones.pack(fill="x", pady=5)
        ttk.Button(botones, text="Agregar cliente",
                   command=self.agregar_cliente).pack(side="left", padx=3)
        ttk.Button(botones, text="Guardar cambios",
                   command=self.modificar_cliente).pack(side="left", padx=3)
        ttk.Button(botones, text="Eliminar cliente",
                   command=self.eliminar_cliente).pack(side="left", padx=3)
        ttk.Button(botones, text="Limpiar",
                   command=self.limpiar_cliente).pack(side="left", padx=3)
        ttk.Button(botones, text="Actualizar",
                   command=self.cargar_clientes).pack(side="left", padx=3)

        cols = ("id", "nombre", "apellido", "curp", "rfc", "fecha", "civil")
        heads = {
            "id": "ID", "nombre": "Nombre", "apellido": "Apellido",
            "curp": "CURP", "rfc": "RFC", "fecha": "Nacimiento",
            "civil": "Estado civil"
        }
        self.tabla_cli = self.tabla(self.tc, cols, heads)
        self.tabla_cli.bind("<<TreeviewSelect>>", self.sel_cliente)

        ttk.Label(self.tc, text="Historial de compras del cliente",
                  font=("Segoe UI", 10, "bold")).pack(anchor="w", pady=(8, 3))
        self.historial = self.tabla(
            self.tc,
            ("fecha", "auto", "monto", "pago"),
            {"fecha": "Fecha", "auto": "Automóvil",
             "monto": "Monto", "pago": "Forma de pago"}
        )
        self.tabla_cli.bind("<<TreeviewSelect>>", self.sel_cliente)

    def cargar_clientes(self):
        if not hasattr(self, "tabla_cli"):
            return
        try:
            filas = self.consultar("""
                SELECT id, nombre, apellido, curp, rfc, fecha_nac, estado_civ
                FROM cliente ORDER BY apellido, nombre
            """)
            self.rellenar(self.tabla_cli, filas)
        except Exception as exc:
            self.error("Error al cargar clientes", exc)

    def sel_cliente(self, _event=None):
        sel = self.tabla_cli.selection()
        if not sel:
            return
        v = self.tabla_cli.item(sel[0], "values")
        self.cliente_id = int(v[0])
        claves = ["nombre", "apellido", "curp", "rfc", "fecha", "civil"]
        for k, valor in zip(claves, v[1:]):
            self.cli_vars[k].set(valor)

        try:
            filas = self.consultar("""
                SELECT ve.fecha_ven, a.marca || ' ' || a.modelo,
                       ve.monto_fin, ve.forma_pag
                FROM venta ve JOIN auto a ON a.id=ve.id_auto
                WHERE ve.id_cliente=%s ORDER BY ve.fecha_ven DESC
            """, (self.cliente_id,))
            self.rellenar(self.historial, filas)
        except Exception as exc:
            self.error("Error al cargar historial", exc)

    def datos_cliente(self):
        d = {k: v.get().strip() for k, v in self.cli_vars.items()}
        if any(not d[k] for k in ["nombre", "apellido", "curp",
                                   "rfc", "fecha"]):
            messagebox.showwarning(
                "Datos incompletos",
                "Nombre, apellido, CURP, RFC y fecha son obligatorios."
            )
            return None
        try:
            nacimiento = date.fromisoformat(d["fecha"])
        except ValueError:
            messagebox.showwarning(
                "Fecha inválida", "Usa el formato AAAA-MM-DD."
            )
            return None
        if len(d["curp"]) != 18:
            messagebox.showwarning("CURP inválida",
                                   "La CURP debe tener 18 caracteres.")
            return None
        return (d["nombre"], d["apellido"], d["curp"].upper(),
                d["rfc"].upper(), nacimiento, d["civil"] or None)

    def agregar_cliente(self):
        datos = self.datos_cliente()
        if datos is None:
            return
        try:
            fila = self.ejecutar("""
                INSERT INTO cliente
                (nombre, apellido, curp, rfc, fecha_nac, estado_civ)
                VALUES (%s,%s,%s,%s,%s,%s) RETURNING id
            """, datos, True)
            self.limpiar_cliente()
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", f"Cliente registrado. ID: {fila[0]}")
        except Exception as exc:
            self.error("No se pudo agregar cliente", exc)

    def modificar_cliente(self):
        if self.cliente_id is None:
            messagebox.showwarning("Selecciona un cliente",
                                   "Selecciona un cliente primero.")
            return
        datos = self.datos_cliente()
        if datos is None:
            return
        try:
            self.ejecutar("""
                UPDATE cliente SET nombre=%s, apellido=%s, curp=%s, rfc=%s,
                fecha_nac=%s, estado_civ=%s WHERE id=%s
            """, (*datos, self.cliente_id))
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Cliente actualizado.")
        except Exception as exc:
            self.error("No se pudo modificar cliente", exc)

    def eliminar_cliente(self):
        if self.cliente_id is None:
            messagebox.showwarning("Selecciona un cliente",
                                   "Selecciona un cliente primero.")
            return
        if not messagebox.askyesno(
            "Confirmar", "¿Eliminar este cliente? Si tiene ventas, "
            "PostgreSQL puede impedirlo."
        ):
            return
        try:
            self.ejecutar("DELETE FROM cliente WHERE id=%s",
                          (self.cliente_id,))
            self.limpiar_cliente()
            self.cargar_clientes()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Cliente eliminado.")
        except Exception as exc:
            self.error("No se pudo eliminar cliente", exc)

    def limpiar_cliente(self):
        self.cliente_id = None
        for v in self.cli_vars.values():
            v.set("")
        self.rellenar(self.historial, [])

    # ---------------- SUCURSALES ----------------

    def interfaz_sucursales(self):
        form = ttk.LabelFrame(self.ts, text="Datos de sucursal", padding=8)
        form.pack(fill="x", pady=5)

        campos = [
            ("Nombre", "nombre"), ("Dirección", "direccion"),
            ("Ciudad", "ciudad"), ("Estado/provincia", "estado_prov"),
            ("Código postal", "cod_post"), ("País", "pais"),
            ("Teléfono", "telefono"), ("Correo", "correo")
        ]
        self.suc_vars = {k: tk.StringVar() for _, k in campos}
        for i, (titulo, clave) in enumerate(campos):
            f, c = divmod(i, 4)
            ttk.Label(form, text=titulo).grid(
                row=f * 2, column=c, sticky="w", padx=4
            )
            ttk.Entry(form, textvariable=self.suc_vars[clave],
                      width=25).grid(
                row=f * 2 + 1, column=c, padx=4, pady=3, sticky="ew"
            )
            form.columnconfigure(c, weight=1)

        self.suc_activa = tk.BooleanVar(value=True)
        ttk.Checkbutton(form, text="Sucursal activa",
                        variable=self.suc_activa).grid(
            row=4, column=0, sticky="w", padx=4
        )

        botones = ttk.Frame(self.ts)
        botones.pack(fill="x", pady=5)
        ttk.Button(botones, text="Agregar",
                   command=self.agregar_sucursal).pack(side="left", padx=3)
        ttk.Button(botones, text="Guardar cambios",
                   command=self.modificar_sucursal).pack(side="left", padx=3)
        ttk.Button(botones, text="Eliminar",
                   command=self.eliminar_sucursal).pack(side="left", padx=3)
        ttk.Button(botones, text="Limpiar",
                   command=self.limpiar_sucursal).pack(side="left", padx=3)
        ttk.Button(botones, text="Actualizar",
                   command=self.cargar_sucursales).pack(side="left", padx=3)

        self.tabla_suc = self.tabla(
            self.ts,
            ("id", "nombre", "direccion", "ciudad", "estado_prov",
             "cod_post", "pais", "telefono", "correo", "activa"),
            {"id": "ID", "nombre": "Sucursal", "direccion": "Dirección",
             "ciudad": "Ciudad", "estado_prov": "Estado/provincia",
             "cod_post": "C.P.", "pais": "País", "telefono": "Teléfono",
             "correo": "Correo", "activa": "Activa"}
        )
        self.tabla_suc.bind("<<TreeviewSelect>>", self.sel_sucursal)

        ttk.Label(self.ts, text="Asignar vendedor a sucursal",
                  font=("Segoe UI", 10, "bold")).pack(anchor="w", pady=5)
        fila = ttk.Frame(self.ts)
        fila.pack(fill="x")
        self.asig_suc = tk.StringVar()
        self.asig_vend = tk.StringVar()
        self.asig_activa = tk.BooleanVar(value=True)

        ttk.Label(fila, text="Sucursal:").pack(side="left")
        self.combo_suc = ttk.Combobox(
            fila, textvariable=self.asig_suc, state="readonly", width=28
        )
        self.combo_suc.pack(side="left", padx=5)
        ttk.Label(fila, text="Vendedor:").pack(side="left")
        self.combo_vend_suc = ttk.Combobox(
            fila, textvariable=self.asig_vend, state="readonly", width=28
        )
        self.combo_vend_suc.pack(side="left", padx=5)
        ttk.Checkbutton(fila, text="Activa",
                        variable=self.asig_activa).pack(side="left", padx=5)
        ttk.Button(fila, text="Asignar",
                   command=self.asignar_vendedor).pack(side="left", padx=5)

        self.tabla_asig = self.tabla(
            self.ts,
            ("id_sucursal", "sucursal", "id_vendedor", "vendedor", "activa"),
            {"id_sucursal": "ID sucursal", "sucursal": "Sucursal",
             "id_vendedor": "ID vendedor", "vendedor": "Vendedor",
             "activa": "Asignación activa"}
        )
        ttk.Button(self.ts, text="Cambiar estado de asignación",
                   command=self.cambiar_asignacion).pack(anchor="w", pady=5)

    def cargar_sucursales(self):
        if not hasattr(self, "tabla_suc"):
            return
        try:
            filas = self.consultar("""
                SELECT id, nombre, direccion, ciudad, est_prov, cod_post,
                       pais, telefono, corr_elec, estado
                FROM sucursal ORDER BY nombre
            """)
            self.rellenar(self.tabla_suc, filas)

            asig = self.consultar("""
                SELECT s.id, s.nombre, v.id, v.nombre || ' ' || v.apellido,
                       g.estado
                FROM gestiona g
                JOIN sucursal s ON s.id=g.id_sucursal
                JOIN vendedor v ON v.id=g.id_vendedor
                ORDER BY s.nombre, v.apellido
            """)
            self.rellenar(self.tabla_asig, asig)

            sucursales = self.consultar(
                "SELECT id,nombre FROM sucursal ORDER BY nombre"
            )
            vendedores = self.consultar(
                "SELECT id,nombre,apellido FROM vendedor ORDER BY apellido"
            )
            self.mapa_suc = {f"{r[0]} | {r[1]}": r[0] for r in sucursales}
            self.mapa_vend_suc = {
                f"{r[0]} | {r[1]} {r[2]}": r[0] for r in vendedores
            }
            self.combo_suc["values"] = list(self.mapa_suc)
            self.combo_vend_suc["values"] = list(self.mapa_vend_suc)
        except Exception as exc:
            self.error("Error al cargar sucursales", exc)

    def sel_sucursal(self, _event=None):
        sel = self.tabla_suc.selection()
        if not sel:
            return
        v = self.tabla_suc.item(sel[0], "values")
        self.sucursal_id = int(v[0])
        claves = ["nombre", "direccion", "ciudad", "estado_prov",
                  "cod_post", "pais", "telefono", "correo"]
        for k, valor in zip(claves, v[1:9]):
            self.suc_vars[k].set(valor)
        self.suc_activa.set(str(v[9]).lower() == "true")

    def datos_sucursal(self):
        d = {k: v.get().strip() for k, v in self.suc_vars.items()}
        if any(not v for v in d.values()):
            messagebox.showwarning("Datos incompletos",
                                   "Completa todos los campos de sucursal.")
            return None
        return tuple(d[k] for k in [
            "nombre", "direccion", "ciudad", "estado_prov",
            "cod_post", "pais", "telefono", "correo"
        ])

    def agregar_sucursal(self):
        datos = self.datos_sucursal()
        if datos is None:
            return
        try:
            fila = self.ejecutar("""
                INSERT INTO sucursal
                (nombre,direccion,ciudad,est_prov,cod_post,pais,telefono,
                 corr_elec,estado)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s) RETURNING id
            """, (*datos, self.suc_activa.get()), True)
            self.limpiar_sucursal()
            self.cargar_sucursales()
            messagebox.showinfo("Éxito", f"Sucursal registrada. ID: {fila[0]}")
        except Exception as exc:
            self.error("No se pudo agregar sucursal", exc)

    def modificar_sucursal(self):
        if self.sucursal_id is None:
            messagebox.showwarning("Selecciona sucursal",
                                   "Selecciona una sucursal primero.")
            return
        datos = self.datos_sucursal()
        if datos is None:
            return
        try:
            self.ejecutar("""
                UPDATE sucursal SET nombre=%s,direccion=%s,ciudad=%s,
                est_prov=%s,cod_post=%s,pais=%s,telefono=%s,corr_elec=%s,
                estado=%s WHERE id=%s
            """, (*datos, self.suc_activa.get(), self.sucursal_id))
            self.cargar_sucursales()
            messagebox.showinfo("Éxito", "Sucursal actualizada.")
        except Exception as exc:
            self.error("No se pudo modificar sucursal", exc)

    def eliminar_sucursal(self):
        if self.sucursal_id is None:
            messagebox.showwarning("Selecciona sucursal",
                                   "Selecciona una sucursal primero.")
            return
        if not messagebox.askyesno("Confirmar", "¿Eliminar esta sucursal?"):
            return
        try:
            self.ejecutar("DELETE FROM gestiona WHERE id_sucursal=%s",
                          (self.sucursal_id,))
            self.ejecutar("DELETE FROM sucursal WHERE id=%s",
                          (self.sucursal_id,))
            self.limpiar_sucursal()
            self.cargar_sucursales()
            messagebox.showinfo("Éxito", "Sucursal eliminada.")
        except Exception as exc:
            self.error("No se pudo eliminar sucursal", exc)

    def limpiar_sucursal(self):
        self.sucursal_id = None
        for v in self.suc_vars.values():
            v.set("")
        self.suc_activa.set(True)

    def asignar_vendedor(self):
        sid = self.mapa_suc.get(self.asig_suc.get())
        vid = self.mapa_vend_suc.get(self.asig_vend.get())
        if not sid or not vid:
            messagebox.showwarning("Datos incompletos",
                                   "Selecciona sucursal y vendedor.")
            return
        try:
            with conectar() as conn:
                with conn.cursor() as cur:
                    cur.execute("""
                        SELECT 1 FROM gestiona
                        WHERE id_sucursal=%s AND id_vendedor=%s
                    """, (sid, vid))
                    existe = cur.fetchone()
                    if existe:
                        cur.execute("""
                            UPDATE gestiona SET estado=%s
                            WHERE id_sucursal=%s AND id_vendedor=%s
                        """, (self.asig_activa.get(), sid, vid))
                    else:
                        cur.execute("""
                            INSERT INTO gestiona
                            (id_sucursal,id_vendedor,estado)
                            VALUES (%s,%s,%s)
                        """, (sid, vid, self.asig_activa.get()))
            self.cargar_sucursales()
            messagebox.showinfo("Éxito", "Asignación guardada.")
        except Exception as exc:
            self.error("No se pudo asignar vendedor", exc)

    def cambiar_asignacion(self):
        sel = self.tabla_asig.selection()
        if not sel:
            messagebox.showwarning("Selecciona asignación",
                                   "Selecciona una asignación primero.")
            return
        v = self.tabla_asig.item(sel[0], "values")
        sid, vid = int(v[0]), int(v[2])
        estado_actual = str(v[4]).lower() == "true"
        try:
            self.ejecutar("""
                UPDATE gestiona SET estado=%s
                WHERE id_sucursal=%s AND id_vendedor=%s
            """, (not estado_actual, sid, vid))
            self.cargar_sucursales()
        except Exception as exc:
            self.error("No se pudo cambiar la asignación", exc)

    # ---------------- VENDEDORES ----------------

    def interfaz_vendedores(self):
        form = ttk.LabelFrame(self.tvend, text="Datos del vendedor",
                              padding=8)
        form.pack(fill="x", pady=5)
        campos = [
            ("Nombre", "nombre"), ("Apellido", "apellido"),
            ("CURP", "curp"), ("RFC", "rfc"),
            ("Fecha nacimiento (AAAA-MM-DD)", "fecha"), ("NSS", "nss")
        ]
        self.vend_vars = {k: tk.StringVar() for _, k in campos}
        for i, (titulo, clave) in enumerate(campos):
            f, c = divmod(i, 3)
            ttk.Label(form, text=titulo).grid(
                row=f * 2, column=c, sticky="w", padx=4
            )
            ttk.Entry(form, textvariable=self.vend_vars[clave],
                      width=30).grid(
                row=f * 2 + 1, column=c, sticky="ew", padx=4, pady=3
            )
            form.columnconfigure(c, weight=1)

        botones = ttk.Frame(self.tvend)
        botones.pack(fill="x", pady=5)
        ttk.Button(botones, text="Agregar",
                   command=self.agregar_vendedor).pack(side="left", padx=3)
        ttk.Button(botones, text="Guardar cambios",
                   command=self.modificar_vendedor).pack(side="left", padx=3)
        ttk.Button(botones, text="Eliminar",
                   command=self.eliminar_vendedor).pack(side="left", padx=3)
        ttk.Button(botones, text="Limpiar",
                   command=self.limpiar_vendedor).pack(side="left", padx=3)
        ttk.Button(botones, text="Actualizar",
                   command=self.cargar_vendedores).pack(side="left", padx=3)

        self.tabla_vend = self.tabla(
            self.tvend,
            ("id", "nombre", "apellido", "curp", "rfc", "fecha", "nss"),
            {"id": "ID", "nombre": "Nombre", "apellido": "Apellido",
             "curp": "CURP", "rfc": "RFC", "fecha": "Nacimiento",
             "nss": "NSS"}
        )
        self.tabla_vend.bind("<<TreeviewSelect>>", self.sel_vendedor)

    def cargar_vendedores(self):
        if not hasattr(self, "tabla_vend"):
            return
        try:
            filas = self.consultar("""
                SELECT id,nombre,apellido,curp,rfc,fecha_nac,nss
                FROM vendedor ORDER BY apellido,nombre
            """)
            self.rellenar(self.tabla_vend, filas)
        except Exception as exc:
            self.error("Error al cargar vendedores", exc)

    def sel_vendedor(self, _event=None):
        sel = self.tabla_vend.selection()
        if not sel:
            return
        v = self.tabla_vend.item(sel[0], "values")
        self.vendedor_id = int(v[0])
        claves = ["nombre", "apellido", "curp", "rfc", "fecha", "nss"]
        for k, valor in zip(claves, v[1:]):
            self.vend_vars[k].set(valor)

    def datos_vendedor(self):
        d = {k: v.get().strip() for k, v in self.vend_vars.items()}
        if any(not d[k] for k in ["nombre", "apellido", "curp",
                                   "rfc", "fecha"]):
            messagebox.showwarning(
                "Datos incompletos",
                "Nombre, apellido, CURP, RFC y fecha son obligatorios."
            )
            return None
        try:
            nacimiento = date.fromisoformat(d["fecha"])
        except ValueError:
            messagebox.showwarning(
                "Fecha inválida", "Usa el formato AAAA-MM-DD."
            )
            return None
        if len(d["curp"]) != 18:
            messagebox.showwarning("CURP inválida",
                                   "La CURP debe tener 18 caracteres.")
            return None
        return (d["nombre"], d["apellido"], d["curp"].upper(),
                d["rfc"].upper(), nacimiento, d["nss"] or None)

    def agregar_vendedor(self):
        datos = self.datos_vendedor()
        if datos is None:
            return
        try:
            fila = self.ejecutar("""
                INSERT INTO vendedor
                (nombre,apellido,curp,rfc,fecha_nac,nss)
                VALUES (%s,%s,%s,%s,%s,%s) RETURNING id
            """, datos, True)
            self.limpiar_vendedor()
            self.cargar_vendedores()
            self.cargar_sucursales()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", f"Vendedor registrado. ID: {fila[0]}")
        except Exception as exc:
            self.error("No se pudo agregar vendedor", exc)

    def modificar_vendedor(self):
        if self.vendedor_id is None:
            messagebox.showwarning("Selecciona vendedor",
                                   "Selecciona un vendedor primero.")
            return
        datos = self.datos_vendedor()
        if datos is None:
            return
        try:
            self.ejecutar("""
                UPDATE vendedor SET nombre=%s,apellido=%s,curp=%s,rfc=%s,
                fecha_nac=%s,nss=%s WHERE id=%s
            """, (*datos, self.vendedor_id))
            self.cargar_vendedores()
            self.cargar_sucursales()
            self.cargar_ventas()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Vendedor actualizado.")
        except Exception as exc:
            self.error("No se pudo modificar vendedor", exc)

    def eliminar_vendedor(self):
        if self.vendedor_id is None:
            messagebox.showwarning("Selecciona vendedor",
                                   "Selecciona un vendedor primero.")
            return
        if not messagebox.askyesno(
            "Confirmar", "¿Eliminar este vendedor? Si tiene ventas o "
            "asignaciones, PostgreSQL puede impedirlo."
        ):
            return
        try:
            self.ejecutar("""
                DELETE FROM gestiona WHERE id_vendedor=%s
            """, (self.vendedor_id,))
            self.ejecutar("""
                DELETE FROM vendedor WHERE id=%s
            """, (self.vendedor_id,))
            self.limpiar_vendedor()
            self.cargar_vendedores()
            self.cargar_sucursales()
            self.cargar_listas_venta()
            messagebox.showinfo("Éxito", "Vendedor eliminado.")
        except Exception as exc:
            self.error("No se pudo eliminar vendedor", exc)

    def limpiar_vendedor(self):
        self.vendedor_id = None
        for v in self.vend_vars.values():
            v.set("")


if __name__ == "__main__":
    root = tk.Tk()
    app = ConcesionariaApp(root)
    root.mainloop()
